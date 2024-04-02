## AWS tfstate Terraform module
![squareops_avatar]

[squareops_avatar]: https://squareops.com/wp-content/uploads/2022/12/squareops-logo.png

### [SquareOps Technologies](https://squareops.com/) Your DevOps Partner for Accelerating cloud journey.
<br>
Terraform module to create Remote State Storage resources for workload deployment on AWS Cloud.

## Usage Example

```hcl
module "backend" {
  source                                    = "squareops/tfstate/aws"
  aws_region                                = "us-east-1"
  aws_account_id                            = "123456789" #AWS Account ID.
  s3_bucket_logging                         = true
  s3_bucket_name                            = "production-tfstate-bucket" #unique global s3 bucket name
  environment                               = prod
  s3_bucket_force_destroy                   = true
  s3_bucket_versioning_enabled              = true
  cloudwatch_logging_enabled                = true
  cloudwatch_log_group_skip_destroy         = false
  cloudwatch_log_retention_in_days          = "90"
  cloudtrail_data_resources_enable          = true
  s3_log_bucket_lifecycle_enabled           = true
  s3_bucket_lifecycle_rules_logging         = {
    default_rule = {
      status                            = false
    }
  }
  cloudtrail_s3_key_prefix                  = "log/"
  s3_bucket_lifecycle_rules_tfstate         = = {
    default_rule = {
      status                            = false
    }
  }
   s3_bucket_enable_object_lock_logging = true
  s3_object_lock_config_logging = {
    s3_bucket_object_lock_mode_logging  = "GOVERNANCE"
    s3_bucket_object_lock_days_logging  = "0"
    s3_bucket_object_lock_years_logging = "2"
  }
  s3_bucket_enable_object_lock_tfstate = true
  s3_object_lock_config_tfstate = {
    s3_bucket_object_lock_mode_tfstate  = "GOVERNANCE"
    s3_bucket_object_lock_days_tfstate  = "10"
    s3_bucket_object_lock_years_tfstate = "0"
  }
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
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.0.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_log_bucket"></a> [log\_bucket](#module\_log\_bucket) | terraform-aws-modules/s3-bucket/aws | 4.1.0 |
| <a name="module_s3_bucket"></a> [s3\_bucket](#module\_s3\_bucket) | terraform-aws-modules/s3-bucket/aws | 4.1.0 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudtrail.s3_cloudtrail](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudtrail) | resource |
| [aws_cloudwatch_log_group.s3_cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_dynamodb_table.dynamodb_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
| [aws_iam_policy.s3_cloudtrail_cloudwatch_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.s3_cloudtrail_cloudwatch_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.s3_cloudtrail_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_kms_alias.custom_alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.kms_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_kms_key_policy.cloudtrail_key_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key_policy) | resource |
| [aws_s3_bucket_lifecycle_configuration.s3_bucket_lifecycle_rules_logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration) | resource |
| [aws_s3_bucket_lifecycle_configuration.s3_bucket_lifecycle_rules_tfstate](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration) | resource |
| [aws_s3_bucket_object_lock_configuration.object_lock_logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_object_lock_configuration) | resource |
| [aws_s3_bucket_object_lock_configuration.object_lock_tfstate](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_object_lock_configuration) | resource |
| [aws_iam_policy_document.bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cloudtrail_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.iam_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tags"></a> [additional\_tags](#input\_additional\_tags) | Additional tags to be applied to AWS resources | `map(string)` | `{}` | no |
| <a name="input_aws_account_id"></a> [aws\_account\_id](#input\_aws\_account\_id) | Account ID of the AWS Account. | `string` | `""` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | Name of the AWS region where S3 bucket is to be created. | `string` | `""` | no |
| <a name="input_cloudtrail_data_resources_enable"></a> [cloudtrail\_data\_resources\_enable](#input\_cloudtrail\_data\_resources\_enable) | Set to true to enable data resources in resource aws\_cloudtrail. | `bool` | `true` | no |
| <a name="input_cloudtrail_enable_log_file_validation"></a> [cloudtrail\_enable\_log\_file\_validation](#input\_cloudtrail\_enable\_log\_file\_validation) | Whether log file integrity validation is enabled. | `bool` | `true` | no |
| <a name="input_cloudtrail_logging_enabled"></a> [cloudtrail\_logging\_enabled](#input\_cloudtrail\_logging\_enabled) | Enables logging for the Cloud trail. | `bool` | `true` | no |
| <a name="input_cloudtrail_s3_key_prefix"></a> [cloudtrail\_s3\_key\_prefix](#input\_cloudtrail\_s3\_key\_prefix) | Specify a prefix for the keys of the log files that CloudTrail will create in the designated S3 bucket. | `string` | `"logs"` | no |
| <a name="input_cloudwatch_log_group_skip_destroy"></a> [cloudwatch\_log\_group\_skip\_destroy](#input\_cloudwatch\_log\_group\_skip\_destroy) | Set to true if do not want the log group to be deleted at destroy time. | `bool` | `true` | no |
| <a name="input_cloudwatch_log_retention_in_days"></a> [cloudwatch\_log\_retention\_in\_days](#input\_cloudwatch\_log\_retention\_in\_days) | Retention period (in days) for CloudWatch log groups. | `number` | `90` | no |
| <a name="input_cloudwatch_logging_enabled"></a> [cloudwatch\_logging\_enabled](#input\_cloudwatch\_logging\_enabled) | CloudWatch log group logging should be enabled or disabled. | `bool` | `true` | no |
| <a name="input_dynamodb_read_capacity"></a> [dynamodb\_read\_capacity](#input\_dynamodb\_read\_capacity) | Number of read units for dynamodb table. | `number` | `20` | no |
| <a name="input_dynamodb_table_attribute_name"></a> [dynamodb\_table\_attribute\_name](#input\_dynamodb\_table\_attribute\_name) | The name of the attribute in the DynamoDB table. | `string` | `"LockID"` | no |
| <a name="input_dynamodb_table_attribute_type"></a> [dynamodb\_table\_attribute\_type](#input\_dynamodb\_table\_attribute\_type) | The data type of the attribute in the DynamoDB table.Valid values are S (string), N (number), B (binary). | `string` | `"S"` | no |
| <a name="input_dynamodb_write_capacity"></a> [dynamodb\_write\_capacity](#input\_dynamodb\_write\_capacity) | Number of write units for dynamodb table. | `number` | `20` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Specify the type of environment(dev, demo, prod) in which the S3 bucket will be created. | `string` | `""` | no |
| <a name="input_kms_deletion_window_in_days"></a> [kms\_deletion\_window\_in\_days](#input\_kms\_deletion\_window\_in\_days) | Waiting period (in days) before the KMS key can be deleted after it's scheduled for deletion. | `number` | `10` | no |
| <a name="input_kms_key_description"></a> [kms\_key\_description](#input\_kms\_key\_description) | Explaination of resource created under aws\_kms\_key. | `string` | `"This key is used to encrypt bucket objects."` | no |
| <a name="input_kms_key_rotation_enabled"></a> [kms\_key\_rotation\_enabled](#input\_kms\_key\_rotation\_enabled) | Whether automatic key rotation should be enabled for the AWS Key Management Service (KMS) key being created. | `bool` | `true` | no |
| <a name="input_logging_read_write_type"></a> [logging\_read\_write\_type](#input\_logging\_read\_write\_type) | Categories of Events for Logging.Valid values are ReadOnly, WriteOnly, All. Default value is All. | `string` | `"All"` | no |
| <a name="input_s3_bucket_attach_deny_insecure_transport_policy"></a> [s3\_bucket\_attach\_deny\_insecure\_transport\_policy](#input\_s3\_bucket\_attach\_deny\_insecure\_transport\_policy) | Whether to attach a policy that denies requests made over insecure transport protocols to the S3 bucket. | `bool` | `true` | no |
| <a name="input_s3_bucket_attach_elb_log_delivery_policy"></a> [s3\_bucket\_attach\_elb\_log\_delivery\_policy](#input\_s3\_bucket\_attach\_elb\_log\_delivery\_policy) | When set to true, it indicates that an Elastic Load Balancer log delivery policy should be attached to the S3 bucket. This policy configures ELB to deliver access logs to the specified S3 bucket. | `bool` | `true` | no |
| <a name="input_s3_bucket_attach_lb_log_delivery_policy"></a> [s3\_bucket\_attach\_lb\_log\_delivery\_policy](#input\_s3\_bucket\_attach\_lb\_log\_delivery\_policy) | when set to true, it indicates that a Load Balancer log delivery policy should be attached to the S3 bucket. This policy configures the Load Balancer to deliver access logs to the specified S3 bucket. | `bool` | `true` | no |
| <a name="input_s3_bucket_attach_policy"></a> [s3\_bucket\_attach\_policy](#input\_s3\_bucket\_attach\_policy) | Whether or not to attach AWS IAM policy to the S3 Bucket. | `bool` | `true` | no |
| <a name="input_s3_bucket_block_public_acls"></a> [s3\_bucket\_block\_public\_acls](#input\_s3\_bucket\_block\_public\_acls) | Whether Amazon S3 should block public ACLs for this bucket. | `bool` | `true` | no |
| <a name="input_s3_bucket_block_public_policy"></a> [s3\_bucket\_block\_public\_policy](#input\_s3\_bucket\_block\_public\_policy) | Whether Amazon S3 should block public bucket policies for this bucket. | `bool` | `true` | no |
| <a name="input_s3_bucket_control_object_ownership"></a> [s3\_bucket\_control\_object\_ownership](#input\_s3\_bucket\_control\_object\_ownership) | Whether to manage S3 Bucket Ownership Controls on this bucket. | `bool` | `true` | no |
| <a name="input_s3_bucket_enable_object_lock_logging"></a> [s3\_bucket\_enable\_object\_lock\_logging](#input\_s3\_bucket\_enable\_object\_lock\_logging) | Whether to enable object lock | `bool` | `true` | no |
| <a name="input_s3_bucket_enable_object_lock_tfstate"></a> [s3\_bucket\_enable\_object\_lock\_tfstate](#input\_s3\_bucket\_enable\_object\_lock\_tfstate) | Whether to enable object lock | `bool` | `true` | no |
| <a name="input_s3_bucket_force_destroy"></a> [s3\_bucket\_force\_destroy](#input\_s3\_bucket\_force\_destroy) | Whether or not to delete all objects from the bucket to allow for destruction of the bucket without error. | `bool` | `false` | no |
| <a name="input_s3_bucket_ignore_public_acls"></a> [s3\_bucket\_ignore\_public\_acls](#input\_s3\_bucket\_ignore\_public\_acls) | Whether Amazon S3 should ignore public ACLs for this bucket. | `bool` | `true` | no |
| <a name="input_s3_bucket_include_global_service_events"></a> [s3\_bucket\_include\_global\_service\_events](#input\_s3\_bucket\_include\_global\_service\_events) | Whether the trail is publishing events from global services such as IAM to the log files. | `bool` | `true` | no |
| <a name="input_s3_bucket_include_management_events"></a> [s3\_bucket\_include\_management\_events](#input\_s3\_bucket\_include\_management\_events) | Whether to include management events for your trail. | `bool` | `true` | no |
| <a name="input_s3_bucket_lifecycle_rules_logging"></a> [s3\_bucket\_lifecycle\_rules\_logging](#input\_s3\_bucket\_lifecycle\_rules\_logging) | A map of lifecycle rules for logging AWS S3 bucket. | <pre>map(object({<br>    status                            = optional(bool, false)<br>    enable_glacier_transition         = optional(bool, false)<br>    enable_deeparchive_transition     = optional(bool, false)<br>    enable_standard_ia_transition     = optional(bool, false)<br>    enable_one_zone_ia                = optional(bool, false)<br>    enable_current_object_expiration  = optional(bool, false)<br>    enable_intelligent_tiering        = optional(bool, false)<br>    enable_glacier_ir                 = optional(bool, false)<br>    lifecycle_configuration_rule_name = optional(string, "lifecycle_configuration_rule_name")<br>    standard_transition_days          = optional(number, 30)<br>    glacier_transition_days           = optional(number, 60)<br>    deeparchive_transition_days       = optional(number, 150)<br>    one_zone_ia_days                  = optional(number, 40)<br>    intelligent_tiering_days          = optional(number, 50)<br>    glacier_ir_days                   = optional(number, 160)<br>    expiration_days                   = number<br>  }))</pre> | <pre>{<br>  "default_rule": {<br>    "status": false<br>  }<br>}</pre> | no |
| <a name="input_s3_bucket_lifecycle_rules_tfstate"></a> [s3\_bucket\_lifecycle\_rules\_tfstate](#input\_s3\_bucket\_lifecycle\_rules\_tfstate) | A map of lifecycle rules for tfstate AWS S3 bucket. | <pre>map(object({<br>    status                            = bool<br>    enable_glacier_transition         = optional(bool, false)<br>    enable_deeparchive_transition     = optional(bool, false)<br>    enable_standard_ia_transition     = optional(bool, false)<br>    enable_one_zone_ia                = optional(bool, false)<br>    enable_current_object_expiration  = optional(bool, false)<br>    enable_intelligent_tiering        = optional(bool, false)<br>    enable_glacier_ir                 = optional(bool, false)<br>    lifecycle_configuration_rule_name = optional(string, "lifecycle_configuration_rule_name")<br>    standard_transition_days          = optional(number, 30)<br>    glacier_transition_days           = optional(number, 60)<br>    deeparchive_transition_days       = optional(number, 150)<br>    one_zone_ia_days                  = optional(number, 40)<br>    intelligent_tiering_days          = optional(number, 50)<br>    glacier_ir_days                   = optional(number, 160)<br>    expiration_days                   = optional(number, 365)<br>  }))</pre> | <pre>{<br>  "default_rule": {<br>    "status": false<br>  }<br>}</pre> | no |
| <a name="input_s3_bucket_logging_enabled"></a> [s3\_bucket\_logging\_enabled](#input\_s3\_bucket\_logging\_enabled) | Configuration for S3 bucket access logging. | `bool` | `true` | no |
| <a name="input_s3_bucket_name"></a> [s3\_bucket\_name](#input\_s3\_bucket\_name) | Name of the S3 bucket to be created. | `string` | `""` | no |
| <a name="input_s3_bucket_object_ownership"></a> [s3\_bucket\_object\_ownership](#input\_s3\_bucket\_object\_ownership) | Object ownership. Valid values: BucketOwnerEnforced, BucketOwnerPreferred or ObjectWriter. | `string` | `"BucketOwnerPreferred"` | no |
| <a name="input_s3_bucket_restrict_public_buckets"></a> [s3\_bucket\_restrict\_public\_buckets](#input\_s3\_bucket\_restrict\_public\_buckets) | Whether Amazon S3 should restrict public bucket policies for this bucket. | `bool` | `true` | no |
| <a name="input_s3_bucket_versioning_enabled"></a> [s3\_bucket\_versioning\_enabled](#input\_s3\_bucket\_versioning\_enabled) | Whether or not to enable versioning for the S3 bucket, which allows multiple versions of an object to be stored in the same bucket. | `bool` | `false` | no |
| <a name="input_s3_log_bucket_lifecycle_enabled"></a> [s3\_log\_bucket\_lifecycle\_enabled](#input\_s3\_log\_bucket\_lifecycle\_enabled) | The S3 bucket's lifecycle rule for log data to be enabled or not. | `bool` | `true` | no |
| <a name="input_s3_object_lock_config_logging"></a> [s3\_object\_lock\_config\_logging](#input\_s3\_object\_lock\_config\_logging) | Additional Configuration for the s3 object lock for AWS S3 logging bucket. | `map(string)` | <pre>{<br>  "s3_bucket_object_lock_days_logging": "",<br>  "s3_bucket_object_lock_mode_logging": "",<br>  "s3_bucket_object_lock_years_logging": ""<br>}</pre> | no |
| <a name="input_s3_object_lock_config_tfstate"></a> [s3\_object\_lock\_config\_tfstate](#input\_s3\_object\_lock\_config\_tfstate) | Additional Configuration for the s3 object lock for AWS S3 tfstate bucket. | `map(string)` | <pre>{<br>  "s3_bucket_object_lock_days_tfstate": "",<br>  "s3_bucket_object_lock_mode_tfstate": "",<br>  "s3_bucket_object_lock_years_tfstate": ""<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_region"></a> [aws\_region](#output\_aws\_region) | Name of the region in which Cloudtrail is created |
| <a name="output_cloudtrail_arn"></a> [cloudtrail\_arn](#output\_cloudtrail\_arn) | The Amazon Resource Name (ARN) of the CloudTrail service that records AWS API calls and events. |
| <a name="output_cloudtrail_id"></a> [cloudtrail\_id](#output\_cloudtrail\_id) | The unique identifier for the CloudTrail service, used for referencing and managing the CloudTrail configuration. |
| <a name="output_dynamodb_table_name"></a> [dynamodb\_table\_name](#output\_dynamodb\_table\_name) | Name of the DynamoDB table that will be used to manage locking and unlocking of the terraform state file. |
| <a name="output_s3_log_bucket_name"></a> [s3\_log\_bucket\_name](#output\_s3\_log\_bucket\_name) | Name of the S3 bucket that will be used to store logs. |
| <a name="output_s3_state_bucket_name"></a> [s3\_state\_bucket\_name](#output\_s3\_state\_bucket\_name) | Specify the region in which an S3 bucket will be created by the module. |
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
