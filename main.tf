provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = var.vpc_azs
  private_subnets = var.vpc_private_subnets
  public_subnets  = var.vpc_public_subnets


  tags = var.tags
}

#TODO: add ec2 module 
module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  
  name = "single-instance"

  instance_type          = "t2.micro"
  key_name               = "user1"
  # subnet_id              = module.vpc.public_subnets
}

# # add rds module 
# module "rds" {
  
# }

# #add load balancer 
# module "load_balancer" {
  
# }