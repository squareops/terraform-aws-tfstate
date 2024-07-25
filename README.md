## AWS tfstate Terraform module
![squareops_avatar]

[squareops_avatar]: https://squareops.com/wp-content/uploads/2022/12/squareops-logo.png

### [SquareOps Technologies](https://squareops.com/) Your DevOps Partner for Accelerating cloud journey.
<br>
Terraform module to create Remote State Storage resources for workload deployment on AWS Cloud.

## Usage Example

```hcl
module "backend" {
  source                       = "squareops/tfstate/aws"
  logging                      = true
  bucket_name                  = "production-tfstate-bucket" #unique global s3 bucket name
  environment                  = "prod"
  force_destroy                = true
  versioning_enabled           = true
  cloudwatch_logging_enabled   = true
  log_retention_in_days        = 90
  log_bucket_lifecycle_enabled = true
  s3_ia_retention_in_days      = 90
  s3_galcier_retention_in_days = 180
}

```
Refer [examples](https://github.com/squareops/terraform-aws-tfstate/tree/main/examples/state-storage-backend) for more details.

## IAM Permissions
The required IAM permissions to create resources from this module can be found [here](https://github.com/squareops/terraform-aws-tfstate/blob/main/IAM.md)

## Important Note
Terraform state locking is a mechanism used to prevent multiple users from simultaneously making changes to the same Terraform state, which could result in conflicts and data loss. A state lock is acquired and maintained by Terraform while it is making changes to the state, and other instances of Terraform are unable to make changes until the lock is released.

An Amazon S3 bucket and a DynamoDB table can be used as a remote backend to store and manage the Terraform state file, and also to implement state locking. The S3 bucket is used to store the state file, while the DynamoDB table is used to store the lock information, such as who acquired the lock and when. Terraform will check the lock state in the DynamoDB table before making changes to the state file in the S3 bucket, and will wait or retry if the lock is already acquired by another instance. This provides a centralized and durable mechanism for managing the Terraform state and ensuring that changes are made in a controlled and safe manner.

Additionally, you may have a log bucket configured to store CloudTrail and CloudWatch logs. This log bucket can have a bucket lifecycle policy in place to automatically manage the lifecycle of log data. For example, log data can be transitioned to Amazon S3 Glacier for long-term storage after a certain period, and eventually to Amazon S3 Infrequent Access storage. This helps in optimizing storage costs and ensures that log data is retained according to your organization's compliance requirements.


## Security & Compliance [<img src="	https://prowler.pro/wp-content/themes/prowler-pro/assets/img/logo.svg" width="250" align="right" />](https://prowler.pro/)

Security scanning is graciously provided by Prowler. Proowler is the leading fully hosted, cloud-native solution providing continuous cluster security and compliance.

In this module, we have implemented the following CIS Compliance checks for S3:

| Benchmark | Description | Status |
|--------|---------------|--------|
| Ensure S3 bucket access logging is enabled on the CloudTrail S3 bucket | Enabled for S3 created using this module. | &#x2714; |
| Ensure the S3 bucket CloudTrail logs to is not publicly accessible | Enabled for S3 created using this module. | &#x2714; |
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.9 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.9 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_kms_key"></a> [kms\_key](#module\_kms\_key) | clouddrove/kms/aws | 1.3.1 |
| <a name="module_log_bucket"></a> [log\_bucket](#module\_log\_bucket) | terraform-aws-modules/s3-bucket/aws | 4.1.2 |
| <a name="module_s3_bucket"></a> [s3\_bucket](#module\_s3\_bucket) | terraform-aws-modules/s3-bucket/aws | 4.1.2 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudtrail.s3_cloudtrail](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudtrail) | resource |
| [aws_cloudwatch_log_group.s3_cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_dynamodb_table.dynamodb_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
| [aws_iam_policy.s3_cloudtrail_cloudwatch_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.s3_cloudtrail_cloudwatch_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.s3_cloudtrail_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_kms_key.mykey](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cloudtrail_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.region](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | Name of the S3 bucket to be created. | `string` | `""` | no |
| <a name="input_cloudwatch_logging_enabled"></a> [cloudwatch\_logging\_enabled](#input\_cloudwatch\_logging\_enabled) | Enable or disable CloudWatch log group logging. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Specify the type of environment(dev, demo, prod) in which the S3 bucket will be created. | `string` | `""` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | Whether or not to delete all objects from the bucket to allow for destruction of the bucket without error. | `bool` | `false` | no |
| <a name="input_log_bucket_lifecycle_enabled"></a> [log\_bucket\_lifecycle\_enabled](#input\_log\_bucket\_lifecycle\_enabled) | Enable or disable the S3 bucket's lifecycle rule for log data. | `bool` | `true` | no |
| <a name="input_log_retention_in_days"></a> [log\_retention\_in\_days](#input\_log\_retention\_in\_days) | Retention period (in days) for CloudWatch log groups. | `number` | `90` | no |
| <a name="input_logging"></a> [logging](#input\_logging) | Configuration for S3 bucket access logging. | `bool` | `true` | no |
| <a name="input_s3_galcier_retention_in_days"></a> [s3\_galcier\_retention\_in\_days](#input\_s3\_galcier\_retention\_in\_days) | Retention period (in days) for moving S3 log data to Glacier storage. | `number` | `180` | no |
| <a name="input_s3_ia_retention_in_days"></a> [s3\_ia\_retention\_in\_days](#input\_s3\_ia\_retention\_in\_days) | Retention period (in days) for moving S3 log data to Infrequent Access storage. | `number` | `90` | no |
| <a name="input_versioning_enabled"></a> [versioning\_enabled](#input\_versioning\_enabled) | Whether or not to enable versioning for the S3 bucket, which allows multiple versions of an object to be stored in the same bucket. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dynamodb_table_name"></a> [dynamodb\_table\_name](#output\_dynamodb\_table\_name) | Name of the DynamoDB table that will be used to manage locking and unlocking of the terraform state file. |
| <a name="output_log_bucket_name"></a> [log\_bucket\_name](#output\_log\_bucket\_name) | Name of the S3 bucket that will be used to store logs. |
| <a name="output_region"></a> [region](#output\_region) | Name of the region in which Cloudtrail is created |
| <a name="output_state_bucket_name"></a> [state\_bucket\_name](#output\_state\_bucket\_name) | Specify the region in which an S3 bucket will be created by the module. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Contribution & Issue Reporting

To report an issue with a project:

  1. Check the repository's [issue tracker](https://github.com/squareops/terraform-aws-tfstate/issues) on GitHub
  2. Search to see if the issue has already been reported
  3. If you can't find an answer to your question in the documentation or issue tracker, you can ask a question by creating a new issue. Make sure to provide enough context and details .

## License

Apache License, Version 2.0, January 2004 (http://www.apache.org/licenses/).

## Support Us

To support a GitHub project by liking it, you can follow these steps:

  1. Visit the repository: Navigate to the [GitHub repository](https://github.com/squareops/terraform-aws-tfstate)

  2. Click the "Star" button: On the repository page, you'll see a "Star" button in the upper right corner. Clicking on it will star the repository, indicating your support for the project.

  3. Optionally, you can also leave a comment on the repository or open an issue to give feedback or suggest changes.

Starring a repository on GitHub is a simple way to show your support and appreciation for the project. It also helps to increase the visibility of the project and make it more discoverable to others.

## Who we are

We believe that the key to success in the digital age is the ability to deliver value quickly and reliably. That’s why we offer a comprehensive range of DevOps & Cloud services designed to help your organization optimize its systems & Processes for speed and agility.

  1. We are an AWS Advanced consulting partner which reflects our deep expertise in AWS Cloud and helping 100+ clients over the last 4 years.
  2. Expertise in Kubernetes and overall container solution helps companies expedite their journey by 10X.
  3. Infrastructure Automation is a key component to the success of our Clients and our Expertise helps deliver the same in the shortest time.
  4. DevSecOps as a service to implement security within the overall DevOps process and helping companies deploy securely and at speed.
  5. Platform engineering which supports scalable,Cost efficient infrastructure that supports rapid development, testing, and deployment.
  6. 24*7 SRE service to help you Monitor the state of your infrastructure and eradicate any issue within the SLA.

We provide [support](https://squareops.com/contact-us/) on all of our projects, no matter how small or large they may be.

You can find more information about our company on this [squareops.com](https://squareops.com/), follow us on [Linkedin](https://www.linkedin.com/company/squareops-technologies-pvt-ltd/), or fill out a [job application](https://squareops.com/careers/). If you have any questions or would like assistance with your cloud strategy and implementation, please don't hesitate to [contact us](https://squareops.com/contact-us/).
