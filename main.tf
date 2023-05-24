provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "4.0.2"
  name   = var.vpc_name
  cidr   = var.vpc_cidr

  azs             = var.vpc_azs
  private_subnets = var.vpc_private_subnets
  public_subnets  = var.vpc_public_subnets
  enable_ipv6     = true

  tags = var.tags
}

#TODO: inspect ec2 module 
# module "ec2-instance" {
#   source = "terraform-aws-modules/ec2-instance/aws"

#   name                        = var.ec2_instance_name
#   instance_type               = var.ec2_instance_type
#   ami                         = var.ec2_instance_ami
#   availability_zone           = module.vpc.azs[0]
#   subnet_id                   = module.vpc.public_subnets[0]
#   associate_public_ip_address = true
#   tags                        = var.tags
# }

# # add rds module 
# module "rds" {

# }

# #add load balancer 
module "elb" {
  source = "terraform-aws-modules/elb/aws"
  version = "4.0.1"
  name                = "elb-test"
  subnets             = [module.vpc.public_subnets[0], module.vpc.private_subnets[0]]
  security_groups     = module.vpc.default_security_group_id
  number_of_instances = 2

  listener = [
    {
      instance_port     = 80
      instance_protocol = "HTTP"
      lb_port           = 80
      lb_protocol       = "HTTP"
    },
    {
      instance_port      = 8080
      instance_protocol  = "http"
      lb_port            = 8080
      lb_protocol        = "http"
      ssl_certificate_id = "arn:aws:acm:us-west-1:235367859451:certificate/6c270328-2cd5-4b2d-8dfd-ae8d0004ad31"
    },
  ]

  health_check = {
    target              = "HTTP:80/"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }
  tags = var.tags
}

module "asg" {
  source = "terraform-aws-modules/autoscaling/aws"
  version = "6.10.0"

  # Autoscaling group
  name = "project-asg"

  min_size                  = 1
  max_size                  = 3
  desired_capacity          = 2
  wait_for_capacity_timeout = 0
  health_check_type         = "EC2"
  vpc_zone_identifier       = [module.vpc.public_subnets[0], module.vpc.public_subnets[1]]


  # Launch template
  launch_template_name        = "project-asg"
  launch_template_description = "Launch template example"
  update_default_version      = true

  image_id          = "ami-ebd02392"
  instance_type     = "t3.micro"
  ebs_optimized     = true
  enable_monitoring = true




  network_interfaces = [
    {
      delete_on_termination = true
      description           = "eth0"
      device_index          = 0
      security_groups       = [module.vpc.default_security_group_id]
    },
    {
      delete_on_termination = true
      description           = "eth1"
      device_index          = 1
      security_groups       = [module.vpc.default_security_group_id]
    }
  ]

  tags = var.tags
}