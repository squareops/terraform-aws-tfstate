output "state_bucket_name" {
  description = "bucket name with id"
  value       = module.s3_bucket.s3_bucket_id
}

output "dynamodb_table_name" {
  description = "dynamodb table name"
  value       = aws_dynamodb_table.dynamodb_table.id
}

output "log_bucket_name" {
  description = "logging table name"
  value       = var.logging ? module.log_bucket[0].s3_bucket_id : null
}
