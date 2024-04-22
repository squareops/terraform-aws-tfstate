output "s3_state_bucket_name" {
  description = "Specify the region in which an S3 bucket will be created by the module."
  value       = module.s3_bucket.s3_bucket_id
}

output "dynamodb_table_name" {
  description = "Name of the DynamoDB table that will be used to manage locking and unlocking of the terraform state file."
  value       = aws_dynamodb_table.dynamodb_table.id
}

output "s3_log_bucket_name" {
  description = "Name of the S3 bucket that will be used to store logs."
  value       = var.s3_bucket_logging_enabled ? module.log_bucket[0].s3_bucket_id : null
}

output "cloudtrail_arn" {
  description = "The Amazon Resource Name (ARN) of the CloudTrail service that records AWS API calls and events."
  value       = var.s3_bucket_logging_enabled ? aws_cloudtrail.s3_cloudtrail[0].arn : null
}

output "cloudtrail_id" {
  description = "The unique identifier for the CloudTrail service, used for referencing and managing the CloudTrail configuration."
  value       = var.s3_bucket_logging_enabled ? aws_cloudtrail.s3_cloudtrail[0].id : null
}

output "aws_region" {
  description = "Name of the region in which Cloudtrail is created"
  value       = var.s3_bucket_logging_enabled ? aws_cloudtrail.s3_cloudtrail[0].home_region : null
}
