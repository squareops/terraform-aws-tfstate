variable "bucket_name" {
  description = "Name of the S3 bucket to be created."
  default     = ""
  type        = string
}

variable "force_destroy" {
  description = "Whether or not to delete all objects from the bucket to allow for destruction of the bucket without error."
  default     = false
  type        = bool
}

variable "versioning_enabled" {
  description = "Whether or not to enable versioning for the S3 bucket, which allows multiple versions of an object to be stored in the same bucket."
  default     = false
  type        = bool
}

variable "logging" {
  description = "Configuration for S3 bucket access logging."
  default     = true
  type        = bool
}

variable "environment" {
  description = "Specify the type of environment(dev, demo, prod) in which the S3 bucket will be created. "
  default     = ""
  type        = string
}

variable "cloudwatch_logging_enabled" {
  description = "Enable or disable CloudWatch log group logging."
  default     = true
  type        = bool
}

variable "log_retention_in_days" {
  description = "Retention period (in days) for CloudWatch log groups."
  default     = 90
  type        = number
}

variable "s3_galcier_retention_in_days" {
  description = "Retention period (in days) for moving S3 log data to Glacier storage."
  default     = 180
  type        = number
}

variable "s3_ia_retention_in_days" {
  description = "Retention period (in days) for moving S3 log data to Infrequent Access storage."
  default     = 90
  type        = number
}

variable "log_bucket_lifecycle_enabled" {
  description = "Enable or disable the S3 bucket's lifecycle rule for log data."
  default     = true
  type        = bool
}
