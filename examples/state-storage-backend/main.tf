locals {
  aws_region                              = "us-east-1"
  aws_account_id                          = "767398031518"
  environment                             = "prod"
  s3_bucket_logging                       = "true"
  s3_bucket_name                          = "prod-tfstate-bucket-example"
  s3_bucket_force_destroy                 = true
  s3_bucket_versioning_enabled            = true
  cloudwatch_logging_enabled              = true
  cloudwatch_log_bucket_lifecycle_enabled = true
  additional_tags = {
    Owner      = "organization_name"
    Expires    = "Never"
    Department = "Engineering"
  }

}

module "backend" {
  source                           = "../../"
  aws_account_id                   = local.aws_account_id
  s3_bucket_logging                = local.s3_bucket_logging
  s3_bucket_name                   = local.s3_bucket_name ############unique global s3 bucket name
  environment                      = local.environment
  s3_bucket_force_destroy          = local.s3_bucket_force_destroy
  s3_bucket_versioning_enabled     = local.s3_bucket_versioning_enabled
  cloudwatch_logging_enabled       = local.cloudwatch_logging_enabled
  cloudwatch_log_retention_in_days = "90"
  s3_log_bucket_lifecycle_enabled  = local.cloudwatch_log_bucket_lifecycle_enabled
  s3_ia_retention_in_days          = "90"
  s3_galcier_retention_in_days     = "180"
  additional_tags                  = local.additional_tags
}