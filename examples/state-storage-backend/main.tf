locals {
  aws_region                              = "us-east-1"
  aws_account_id                          = "767398031518" # AWS Account ID
  environment                             = "prod"
  s3_bucket_logging                       = "true"
  s3_bucket_name                          = "prod-tfstate"
  s3_bucket_force_destroy                 = true
  s3_bucket_versioning_enabled            = true
  cloudwatch_logging_enabled              = true
  cloudwatch_log_bucket_lifecycle_enabled = true
  cloudwatch_log_group_skip_destroy       = false
  cloudtrail_data_resources_enable        = true
  cloudtrail_s3_key_prefix                = "logs"
   # Object Lock configuration
  object_lock_configuration = {
    object_lock_enabled = true
    rule = {
      default_retention = {
        mode = "GOVERNANCE"
        days = 30
      }
    }
  }
  additional_tags = {
    Owner      = "organization_name"
    Expires    = "Never"
    Department = "Engineering"
  }
  # Define the lifecycle rules
  s3_bucket_lifecycle_rules = {
  log_rule = {
    id                            = "1"
    prefix                        = "log/"
    expiration_days               = 120
    transition_standard_ia_days   = 40
    transition_glacier_days       = 80
    filter_prefix                 = "log/"
    filter_tags                   = {
      rule      = "log"
      autoclean = "true"
    }
    status                        = "Enabled"
  }
}
}

module "backend" {
  source                            = "../.."
  aws_region                        = local.aws_region
  aws_account_id                    = local.aws_account_id
  s3_bucket_logging                 = local.s3_bucket_logging
  s3_bucket_name                    = local.s3_bucket_name ############unique global s3 bucket name
  environment                       = local.environment
  s3_bucket_force_destroy           = local.s3_bucket_force_destroy
  s3_bucket_versioning_enabled      = local.s3_bucket_versioning_enabled
  cloudwatch_logging_enabled        = local.cloudwatch_logging_enabled
  cloudwatch_log_group_skip_destroy = local.cloudwatch_log_group_skip_destroy
  cloudwatch_log_retention_in_days  = "90"
  s3_log_bucket_lifecycle_enabled   = local.cloudwatch_log_bucket_lifecycle_enabled
  # s3_ia_retention_in_days           = "90"
  # s3_galcier_retention_in_days      = "180"
  s3_bucket_lifecycle_rules         = local.s3_bucket_lifecycle_rules
  cloudtrail_data_resources_enable = local.cloudtrail_data_resources_enable
  cloudtrail_s3_key_prefix         = local.cloudtrail_s3_key_prefix
  s3_bucket_object_lock_mode       = "GOVERNANCE"
  s3_bucket_object_lock_days       = "30"
  s3_bucket_enable_object_lock     = true
  additional_tags                  = local.additional_tags
}