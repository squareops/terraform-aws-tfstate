output "bucket_region" {
  description = "In which region S3 bucket will create"
  value       = var.region
}

output "state_bucket_name" {
  description = "bucket name with id"
  value       = module.backend.state_bucket_name
}

output "dynamodb_table_name" {
  description = "dynamodb table name"
  value       = module.backend.dynamodb_table_name
}
