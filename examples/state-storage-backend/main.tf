locals {
  aws_region                              = "us-east-1"
  aws_account_id                          = "767398031518" # AWS Account ID
  environment                             = "prod"
  s3_bucket_logging_enabled               = "true"
  s3_bucket_name                          = "prod-tfstate"
  s3_bucket_force_destroy                 = true
  s3_bucket_versioning_enabled            = true
  cloudwatch_logging_enabled              = true
  cloudwatch_log_bucket_lifecycle_enabled = true
  cloudwatch_log_group_skip_destroy       = false
  cloudtrail_data_resources_enable        = true
  cloudtrail_s3_key_prefix                = "logs"
  additional_tags = {
    Owner      = "organization_name"
    Expires    = "Never"
    Department = "Engineering"
  }

  # Define the lifecycle rules for logging S3 bucket

  s3_bucket_lifecycle_rules_logging = {
    default_rule = {
      status = false
    }
  }

  # Define the lifecycle rules for tfstate S3 bucket

  s3_bucket_lifecycle_rules_tfstate = {
    default_rule = {
      status = true
    }
  }
}

module "backend" {
  source                               = "squareops/tfstate/aws"
  aws_region                           = local.aws_region
  aws_account_id                       = local.aws_account_id
  s3_bucket_logging_enabled            = local.s3_bucket_logging_enabled
  s3_bucket_name                       = local.s3_bucket_name ############unique global s3 bucket name
  environment                          = local.environment
  s3_bucket_force_destroy              = local.s3_bucket_force_destroy
  s3_bucket_versioning_enabled         = local.s3_bucket_versioning_enabled
  cloudwatch_logging_enabled           = local.cloudwatch_logging_enabled
  cloudwatch_log_group_skip_destroy    = local.cloudwatch_log_group_skip_destroy
  cloudwatch_log_retention_in_days     = "90"
  cloudtrail_data_resources_enable     = local.cloudtrail_data_resources_enable
  s3_log_bucket_lifecycle_enabled      = local.cloudwatch_log_bucket_lifecycle_enabled
  s3_bucket_lifecycle_rules_logging    = local.s3_bucket_lifecycle_rules_logging
  cloudtrail_s3_key_prefix             = local.cloudtrail_s3_key_prefix
  s3_bucket_lifecycle_rules_tfstate    = local.s3_bucket_lifecycle_rules_tfstate
  additional_tags                      = local.additional_tags
  s3_bucket_enable_object_lock_logging = true
  s3_object_lock_config_logging = {
    s3_bucket_object_lock_mode_logging  = "GOVERNANCE"
    s3_bucket_object_lock_days_logging  = "0"
    s3_bucket_object_lock_years_logging = "2"
  }
  s3_bucket_enable_object_lock_tfstate = true
  s3_object_lock_config_tfstate = {
    s3_bucket_object_lock_mode_tfstate  = "GOVERNANCE"
    s3_bucket_object_lock_days_tfstate  = "10"
    s3_bucket_object_lock_years_tfstate = "0"
  }
}
