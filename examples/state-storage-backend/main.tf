locals {
  region      = "us-east-1"
  environment = "prod"
  additional_tags = {
    Owner      = "Organization_Name"
    Expires    = "Never"
    Department = "Engineering"
  }
}

module "backend" {
  source             = "squareops/tfstate/aws"
  logging            = true
  cloudwatch_logging = true
  environment        = local.environment
  bucket_name        = "production-tfstate-bucket-personel" #unique global s3 bucket name
  force_destroy      = true
  versioning_enabled = true
}
