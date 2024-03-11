locals {
  region                                  = "us-east-1"
  environment                             = "prod"
  aws_account_id                          = ""
  additional_tags = {
    Owner      = "organization_name"
    Expires    = "Never"
    Department = "Engineering"
  }

}

module "backend" {
  source                                  = "squareops/tfstate/aws"
  environment                             = local.environment
  s3_bucket_logging                       = "true"
  s3_bucket_name                          = "production-tfstate-bucket"
  s3_bucket_force_destroy                 = true
  s3_bucket_versioning_enabled            = true
  cloudwatch_logging_enabled              = true
  cloudwatch_log_retention_in_days        = 90
  s3_log_bucket_lifecycle_enabled         = true
  s3_ia_retention_in_days                 = 90
  s3_galcier_retention_in_days            = 180
  additional_tags                  = local.additional_tags
}


