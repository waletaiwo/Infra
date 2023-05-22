provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name   = var.vpc_name
  cidr   = var.vpc_cidr

  azs             = var.vpc_azs
  private_subnets = var.vpc_private_subnets
  public_subnets  = var.vpc_public_subnets
  enable_ipv6     = true

  tags = var.tags
}

# module "security-group" {
#   source            = "terraform-aws-modules/security-group/aws"
#   security_group_id = module.vpc.default_security_group_id
#   vpc_id            = module.vpc
# }

#TODO: inspect ec2 module 
module "ec2-instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name                        = var.ec2_instance_name
  depends_on = [ module.vpc ]
  instance_type               = var.ec2_instance_type
  ami                         = var.ec2_instance_ami
  availability_zone           = module.vpc.azs[0]
  subnet_id                   = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  tags                        = var.tags
}

# # add rds module 
# module "rds" {

# }

# #add load balancer 
# module "load_balancer" {

# }