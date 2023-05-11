locals {
  region      = "us-east-2"
  environment = "prod"
  additional_tags = {
    Owner      = "organization_name"
    Expires    = "Never"
    Department = "Engineering"
  }
}

module "backend" {
  source             = "../../"
  logging            = true
  environment        = local.environment
  bucket_name        = "production-tfstate-buckett" #unique global s3 bucket name
  force_destroy      = true
  versioning_enabled = true
}
