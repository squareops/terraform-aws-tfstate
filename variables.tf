variable "additional_tags" {
  description = "Additional tags to be applied to AWS resources"
  type        = map(string)
  default     = {
    Owner      = "organization_name"
    Expires    = "Never"
    Department = "Engineering"
  }
}

variable "aws_region" {
  description = "Name of the AWS region where S3 bucket is to be created."
  default     = "us-east-1"
  type        = string
}

variable "aws_account_id" {
  description = "Account ID of the AWS Account."
  default     = ""
  type        = string
}

variable "kms_deletion_window_in_days" {
  description = " Waiting period (in days) before the KMS key can be deleted after it's scheduled for deletion."
  default     = 10
  type        = number
}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket to be created."
  default     = ""
  type        = string
}

variable "s3_bucket_force_destroy" {
  description = "Whether or not to delete all objects from the bucket to allow for destruction of the bucket without error."
  default     = false
  type        = bool
}

variable "s3_bucket_attach_policy" {
  description = "Whether or not to attach AWS IAM policy to the S3 Bucket."
  default     = true
  type        = bool
}

variable "s3_bucket_attach_deny_insecure_transport_policy" {
  description = "Whether to attach a policy that denies requests made over insecure transport protocols to the S3 bucket."
  default     = true
  type        = bool
}


variable "s3_bucket_versioning_enabled" {
  description = "Whether or not to enable versioning for the S3 bucket, which allows multiple versions of an object to be stored in the same bucket."
  default     = false
  type        = bool
}

variable "s3_bucket_logging" {
  description = "Configuration for S3 bucket access logging."
  default     = true
  type        = bool
}

variable "s3_bucket_block_public_acls" {
  description = "Whether Amazon S3 should block public ACLs for this bucket."
  default     = true
  type        = bool
}

variable "s3_bucket_block_public_policy" {
  description = "Whether Amazon S3 should block public bucket policies for this bucket.	"
  default     = true
  type        = bool
}

variable "s3_bucket_ignore_public_acls" {
  description = "Whether Amazon S3 should ignore public ACLs for this bucket."
  default     = true
  type        = bool
}

variable "s3_bucket_restrict_public_buckets" {
  description = "Whether Amazon S3 should restrict public bucket policies for this bucket."
  default     = true
  type        = bool
}

variable "s3_bucket_control_object_ownership" {
  description = "Whether to manage S3 Bucket Ownership Controls on this bucket."
  default     = true
  type        = bool
}

variable "s3_bucket_object_ownership" {
  description = "Object ownership. Valid values: BucketOwnerEnforced, BucketOwnerPreferred or ObjectWriter."
  default     = "BucketOwnerPreferred"
  type        = string
}

variable "environment" {
  description = "Specify the type of environment(dev, demo, prod) in which the S3 bucket will be created. "
  default     = ""
  type        = string
}

variable "dynamodb_read_capacity" {
  description = "Number of read units for dynamodb table."
  default     = 20
  type        = number
}

variable "dynamodb_write_capacity" {
  description = "Number of write units for dynamodb table."
  default     = 20
  type        = number
}

variable "name" {
  description = "Name of the Attribute."
  default     = "LockID"
  type        = string
}

variable "type" {
  description = "Attribute type. Valid values are S (string), N (number), B (binary)."
  default     = "S"
  type        = string
}

variable "cloudwatch_logging_enabled" {
  description = "Enable or disable CloudWatch log group logging."
  default     = true
  type        = bool
}

variable "cloudwatch_log_retention_in_days" {
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

variable "s3_log_bucket_lifecycle_enabled" {
  description = "Enable or disable the S3 bucket's lifecycle rule for log data."
  default     = true
  type        = bool
}

variable "cloudtrail_enable_logging" {
  description = "Enables logging for the trail."
  default     = true
  type        = bool
}

variable "s3_bucket_include_global_service_events" {
  description = "Whether the trail is publishing events from global services such as IAM to the log files."
  default     = true
  type        = bool
}

variable "cloudtrail_enable_log_file_validation" {
  description = "Whether log file integrity validation is enabled."
  default     = true
  type        = bool
}

variable "s3_bucket_include_management_events" {
  description = "Whether to include management events for your trail."
  default     = true
  type        = bool
}

variable "s3_bucket_attach_elb_log_delivery_policy" {
  description = "When set to true, it indicates that an Elastic Load Balancer log delivery policy should be attached to the S3 bucket. This policy configures ELB to deliver access logs to the specified S3 bucket."
  default     = true
  type        = bool
}

variable "s3_bucket_attach_lb_log_delivery_policy" {
  description = "when set to true, it indicates that a Load Balancer log delivery policy should be attached to the S3 bucket. This policy configures the Load Balancer to deliver access logs to the specified S3 bucket."
  default     = true
  type        = bool
}

variable "enable_key_rotation" {
  description = "Whether automatic key rotation should be enabled for the AWS Key Management Service (KMS) key being created."
  default     = true
  type        = bool
}


