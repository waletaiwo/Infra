# Infra

To deploy an AWS infrastructure with Terraform and manage resources with Ansible

## Description

For this project, the plan is to utilize Terraform for provisioning the necessary AWS infrastructure, while Ansible will be utilized to manage the resources. Terraform will be utilized to both create and configure the infrastructure resources such as VPC, EC2 instances, RDS databases, and load balancers. Once the infrastructure is set up, Ansible will then be used to manage the configuration of the resources. This approach provides an efficient and reliable way to manage the infrastructure as code, version control and avoid human errors. The combination of Terraform and Ansible will create a powerful infrastructure automation pipeline, leading to more effective management of the infrastructure.

## Tech Stack

**Cloud Service Provider:** AWS ( VPC, EC2 instances, RDS databases, and load balancers )  

**Infrastructure as Code:** Terrafrom

**Configuration Management:** Ansible

## Installation

To download the provider we need to run the following command

 ```terraform
terraform init
```

After this, we have to check what kind of resources are going to deploy. We can check this using

``` terraform
terraform plan
```  

Now we are going to apply these settings using

``` terraform
terraform apply
```

## Usage

Add aws credentials to providers block in main.tf for code to run on your infrastructure.

```terraform
provider "aws" {
  region = var.region
  secret_key = "add secret key here"
  access_key = "add access key here"
}
```

or Set secrets via environment variables in your cli

```bash
export TF_VAR_AWS_ACCESS_KEY_ID= add access key value here
export TF_VAR_SECRET_ACCESS_KEY= add secret key value here
```

Use either of the two options above not the two.
