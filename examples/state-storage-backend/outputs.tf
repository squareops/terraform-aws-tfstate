output "s3_bucket_region" {
  description = "Specify the region in which an S3 bucket will be created by the module."
  value       = module.backend.aws_region
}

output "s3_state_bucket_name" {
  description = "Name of the S3 bucket that will be used to store the Terraform state file."
  value       = module.backend.s3_state_bucket_name
}

output "dynamodb_table_name" {
  description = "Name of the DynamoDB table that will be used to manage locking and unlocking of the Terraform state file."
  value       = module.backend.dynamodb_table_name
}

output "s3_log_bucket_name" {
  description = "Name of the S3 bucket that will be used to store logs for this module."
  value       = module.backend.s3_log_bucket_name
}

output "cloudtrail_arn" {
  description = "The Amazon Resource Name (ARN) of the CloudTrail service that records AWS API calls and events."
  value       = module.backend.cloudtrail_arn
}

output "cloudtrail_id" {
  description = "The unique identifier for the CloudTrail service, used for referencing and managing the CloudTrail configuration."
  value       = module.backend.cloudtrail_id
}
