locals {
  region      = "us-east-2"
  environment = "dev"
}

module "backend" {
  source = "../../"
  environment        = local.environment
  bucket_name        = "production-tfstate-bucket" #unique global s3 bucket name
  force_destroy      = true
  versioning_enabled = true
  logging            = true

}
