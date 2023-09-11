locals {
  region      = "us-east-2"
  environment = "prod"
  additional_tags = {
    Owner      = "organization_name"
    Expires    = "Never"
    Department = "Engineering"
  }
}

module "backend" {
  source             = "squareops/tfstate/aws"
  logging            = true
  cloudwatch_logging = true
  enable_lifecycle_rule = true
  cw_retention_days = 90
  s3_ia_retention_days = 90
  s3_galcier_retention_days = 180
  environment        = local.environment
  bucket_name        = "production-tfstate-bucket" #unique global s3 bucket name
  force_destroy      = true
  versioning_enabled = true
}
