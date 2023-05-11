output "state_bucket_name" {
  description = "Specify the region in which an S3 bucket will be created by the module."
  value       = module.s3_bucket.s3_bucket_id
}

output "dynamodb_table_name" {
  description = "Name of the DynamoDB table that will be used to manage locking and unlocking of the Terraform state file."
  value       = aws_dynamodb_table.dynamodb_table.id
}

output "log_bucket_name" {
  description = "Name of the S3 bucket that will be used to store logs for this module."
  value       = var.logging ? module.log_bucket[0].s3_bucket_id : null
}
