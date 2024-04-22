<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.9 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_backend"></a> [backend](#module\_backend) | ../../ | n/a |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudtrail_arn"></a> [cloudtrail\_arn](#output\_cloudtrail\_arn) | The Amazon Resource Name (ARN) of the CloudTrail service that records AWS API calls and events. |
| <a name="output_cloudtrail_id"></a> [cloudtrail\_id](#output\_cloudtrail\_id) | The unique identifier for the CloudTrail service, used for referencing and managing the CloudTrail configuration. |
| <a name="output_dynamodb_table_name"></a> [dynamodb\_table\_name](#output\_dynamodb\_table\_name) | Name of the DynamoDB table that will be used to manage locking and unlocking of the Terraform state file. |
| <a name="output_s3_bucket_region"></a> [s3\_bucket\_region](#output\_s3\_bucket\_region) | Specify the region in which an S3 bucket will be created by the module. |
| <a name="output_s3_log_bucket_name"></a> [s3\_log\_bucket\_name](#output\_s3\_log\_bucket\_name) | Name of the S3 bucket that will be used to store logs for this module. |
| <a name="output_s3_state_bucket_name"></a> [s3\_state\_bucket\_name](#output\_s3\_state\_bucket\_name) | Name of the S3 bucket that will be used to store the Terraform state file. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Our Other Projects

We have a number of other projects that you might be interested in:

  1. [terraform-aws-vpc](https://github.com/squareops/terraform-aws-vpc): Terraform module to create Networking resources for workload deployment on AWS Cloud.

  2. [terraform-aws-keypair](https://github.com/squareops/terraform-aws-keypair): Terraform module which creates EC2 key pair on AWS. The private key will be stored on SSM.

     Follow Us:

     To stay updated on our projects and future release, follow us on
     [GitHub](https://github.com/squareops/),
     [LinkedIn](https://www.linkedin.com/company/squareops-technologies-pvt-ltd/)

     By joining our both the [email](https://github.com/squareops) and [Slack community](https://github.com/squareops), you can benefit from the different ways in which we provide support. You can receive timely notifications and updates through email and engage in real-time conversations and discussions with other members through Slack. This combination of resources can help you stay informed, get help when you need it, and contribute to the project in a meaningful way.  

## Security, Validation and pull-requests
we have offered here high standard, quality code. Hence we are using several [pre-commit hooks](.pre-commit-config.yaml) and [GitHub Actions](https://gitlab.com/sq-ia/aws/eks/-/tree/v1.0.0#security-validation-and-pull-requests) as a workflow. So here we will create pull-requests to any branch and validate the request automatically using pre-commit tool.

## License

Apache License, Version 2.0, January 2004 (http://www.apache.org/licenses/).

## Support Us

To support a GitHub project by liking it, you can follow these steps:

  1. Visit the repository: Navigate to the GitHub repository.

  2. Click the "Star" [button](https://github.com/squareops/terraform-aws-vpc): On the repository page, you'll see a "Star" button in the upper right corner. Clicking on it will star the repository, indicating your support for the project.

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

You can find more information about our company on this [squareops.com](https://squareops.com/), follow us on [linkdin](https://www.linkedin.com/company/squareops-technologies-pvt-ltd/), or fill out a [job application](https://squareops.com/careers/). If you have any questions or would like assistance with your cloud strategy and implementation, please don't hesitate to [contact us](https://squareops.com/contact-us/).
