variable "bucket_name" {
  description = "bucket name"
  default     = ""
  type        = string
}

variable "force_destroy" {
  description = "Indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error"
  default     = false
  type        = bool
}

variable "versioning_enabled" {
  description = "keeping multiple variants of an object in the same bucket"
  default     = false
  type        = bool
}

variable "logging" {
  description = "Map containing access bucket logging configuration"
  default     = true
  type        = bool
}

variable "environment" {
  description = "Select enviroment type: dev, demo, prod"
  default     = "demo"
  type        = string
}
