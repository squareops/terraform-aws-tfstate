resource "aws_kms_key" "kms_key" {
  description             = var.kms_key_description
  deletion_window_in_days = var.kms_deletion_window_in_days
  tags = merge(
    { "Name" = format("%s-%s", var.environment, var.s3_bucket_name) },
    var.additional_tags,
  )
}
resource "aws_iam_role" "iam_role" {
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
    { "Name" = format("%s-%s", var.environment, var.s3_bucket_name) },
    var.additional_tags,
  )
}

data "aws_iam_policy_document" "bucket_policy" {
  statement {
    principals {
      type        = "AWS"
      identifiers = [aws_iam_role.iam_role.arn]
    }

    actions = [
      "s3:ListBucket",
    ]

    resources = [
      "arn:aws:s3:::${format("%s-%s", var.s3_bucket_name, var.aws_account_id)}",
    ]
  }
}

module "s3_bucket" {
  source                                = "terraform-aws-modules/s3-bucket/aws"
  version                               = "4.1.0"
  bucket                                = format("%s-%s", var.s3_bucket_name, var.aws_account_id)
  force_destroy                         = var.s3_bucket_force_destroy
  attach_policy                         = var.s3_bucket_attach_policy
  policy                                = data.aws_iam_policy_document.bucket_policy.json
  attach_deny_insecure_transport_policy = var.s3_bucket_attach_deny_insecure_transport_policy
  versioning = {
    enabled = var.s3_bucket_versioning_enabled
  }

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        kms_master_key_id = aws_kms_key.kms_key.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }

  logging = var.s3_bucket_logging ? {
    target_bucket = module.log_bucket[0].s3_bucket_id
    target_prefix = "log/"
  } : {}

  # S3 bucket-level Public Access Block configuration
  block_public_acls       = var.s3_bucket_block_public_acls
  block_public_policy     = var.s3_bucket_block_public_policy
  ignore_public_acls      = var.s3_bucket_ignore_public_acls
  restrict_public_buckets = var.s3_bucket_restrict_public_buckets

  # S3 Bucket Ownership Controls
  control_object_ownership = var.s3_bucket_control_object_ownership
  object_ownership         = var.s3_bucket_object_ownership
}

resource "aws_dynamodb_table" "dynamodb_table" {
  name           = format("%s-%s-%s", var.s3_bucket_name, "lock-dynamodb", var.aws_account_id)
  hash_key       = "LockID"
  read_capacity  = var.dynamodb_read_capacity
  write_capacity = var.dynamodb_write_capacity

  attribute {
    name = var.dynamodb_table_attribute_name
    type = var.dynamodb_table_attribute_type
  }

  tags = merge(
    { "Name" = format("%s-%s-%s", var.s3_bucket_name, "lock-dynamodb", var.aws_account_id) },
    var.additional_tags,
  )
}
