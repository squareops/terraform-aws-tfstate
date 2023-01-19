provider "aws" {
  region = var.region
}

locals {
  region      = "us-east-1"
  environment = "dev"
}

module "backend" {
  source = "../../"

  region             = local.region
  environment        = local.environment
  bucket_name        = "example-bucket" #unique global s3 bucket name
  force_destroy      = true
  versioning_enabled = true
}
