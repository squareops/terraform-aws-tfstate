provider "aws" {
  region = var.region
}


locals {
  tags = {
    Automation  = "true"
    Environment = var.environment
  }
}

data "aws_caller_identity" "current" {}

resource "aws_kms_key" "mykey" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
  tags = merge(
    { "Name" = format("%s-%s", var.environment, var.bucket_name) },
    local.tags,
  )
}
resource "aws_iam_role" "this" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
  tags = merge(
    { "Name" = format("%s-%s", var.environment, var.bucket_name) },
    local.tags,
  )
}

data "aws_iam_policy_document" "bucket_policy" {
  statement {
    principals {
      type        = "AWS"
      identifiers = [aws_iam_role.this.arn]
    }

    actions = [
      "s3:ListBucket",
    ]

    resources = [
      "arn:aws:s3:::${format("%s-%s", var.bucket_name, data.aws_caller_identity.current.account_id)}",
    ]
  }
}

module "s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.4.0"

  bucket        = format("%s-%s", var.bucket_name, data.aws_caller_identity.current.account_id)
  acl           = "private"
  force_destroy = var.force_destroy

  attach_policy = true
  policy        = data.aws_iam_policy_document.bucket_policy.json

  attach_deny_insecure_transport_policy = true

  versioning = {
    enabled = var.versioning_enabled
  }

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        kms_master_key_id = aws_kms_key.mykey.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }

  logging = var.logging ? {
    target_bucket = module.log_bucket[0].s3_bucket_id
    target_prefix = "log/"
  } : {}

  # S3 bucket-level Public Access Block configuration
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  # S3 Bucket Ownership Controls
  control_object_ownership = false
  object_ownership         = "bucket-owner-full-control"
}

resource "aws_dynamodb_table" "dynamodb_table" {
  name           = format("%s-%s-%s", var.bucket_name, "lock-dynamodb", data.aws_caller_identity.current.account_id)
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = merge(
    { "Name" = format("%s-%s-%s", var.bucket_name, "lock-dynamodb", data.aws_caller_identity.current.account_id) },
    local.tags,
  )
}
