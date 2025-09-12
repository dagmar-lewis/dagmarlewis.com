# Terraform Infrastructure for Personal Portfolio Website

This repository contains Terraform code to provision the infrastructure for a personal portfolio website on AWS. The infrastructure is designed to be secure, scalable, and cost-effective.

## Infrastructure Overview

The Terraform code provisions the following AWS resources:

*   **Networking:**
    *   A Virtual Private Cloud (VPC) with a private subnet.
    *   An Internet Gateway and an Egress-Only Internet Gateway to allow outbound traffic from the private subnet.
    *   Route tables to control the flow of traffic within the VPC.
    *   Security groups to control inbound and outbound traffic to the EC2 instance and other resources.
    *   VPC endpoints for AWS Systems Manager (SSM), Amazon S3, and Amazon Elastic Container Registry (ECR) to allow private access to these services from the EC2 instance.

*   **Compute:**
    *   An EC2 instance launched in the private subnet.
    *   The EC2 instance is provisioned with a user data script that installs:
        *   Docker
        *   AWS CLI
        *   Caddy (a modern, easy-to-use web server)
    *   The user data script also pulls a Docker image from a private ECR repository and runs it as a container.

*   **Storage:**
    *   Two Amazon S3 buckets:
        *   One bucket to store the Terraform state, with versioning and server-side encryption enabled.
        *   Another bucket to store files that are used by the EC2 instance (e.g., Caddyfile, docker-compose.yml).

*   **IAM:**
    *   An IAM role for the EC2 instance with policies attached to allow access to:
        *   AWS Systems Manager (SSM) for remote management.
        *   Amazon S3 to download configuration files.
        *   Amazon ECR to pull Docker images.

*   **ECR:**
    *   An Amazon Elastic Container Registry (ECR) repository to store the Docker image for the portfolio website.

*   **CloudFront:**
    *   An Amazon CloudFront distribution to serve the website content from the EC2 instance. This provides a global content delivery network (CDN) for low-latency access to the website.

## Deployment

To deploy the infrastructure, you will need to have the following prerequisites installed:

*   [Terraform](https://www.terraform.io/downloads.html)
*   [AWS CLI](https://aws.amazon.com/cli/)

You will also need to have your AWS credentials configured.

Once you have the prerequisites installed and your AWS credentials configured, you can deploy the infrastructure by running the following commands:

```sh
terraform init
terraform apply
```

## Inputs

The following input variables can be configured in the `variables.tf` file:

| Name | Description | Type | Default |
| --- | --- | --- | --- |
| `project_name` | The name of the project. | `string` | `"dagmarlewis_portfolio"` |
| `region` | The AWS region to deploy the infrastructure in. | `string` | `"us-east-1"` |
| `files_bucket_name` | The name of the S3 bucket to store files for the EC2 instance. | `string` | `"dagmarlewis.com-tf-files"` |
| `instance_type` | The EC2 instance type. | `string` | `"t2.micro"` |
| `ami` | The Amazon Machine Image (AMI) to use for the EC2 instance. | `string` | `"ami-020cba7c55df1f615"` |
| `vpc_cidr_block` | The CIDR block for the VPC. | `string` | `"10.0.0.0/16"` |
| `subnet_cidr_block` | The CIDR block for the private subnet. | `string` | `"10.0.1.0/24"` |
| `cloudfront_distrubution_state` | The state of the CloudFront distribution. | `bool` | `false` |
| `ecr_repo_name` | The name of the ECR repository. | `string` | `"dagmarlewis_portfolio"` |

## Outputs

The following outputs will be displayed after the infrastructure is successfully deployed:

| Name | Description |
| --- | --- |
| `cloudfront_url` | The URL of the CloudFront distribution. |
| `ec2id` | The ID of the EC2 instance. |
| `registry_url` | The URL of the ECR repository. |
