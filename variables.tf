variable "vpc_name" {
  description = "Name for vpc"
  type        = string
  default     = "Infra-vpc"
}

variable "vpc_cidr" {
  description = "Vpc cidr range"
  type        = string
  default     = "10.0.0.0/16"

}

variable "vpc_azs" {
  description = "List of az for vpc"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]

}

variable "vpc_private_subnets" {
  description = "vpc private subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

}

variable "vpc_public_subnets" {
  description = "vpc public subnets"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

}

variable "tags" {
  description = "tags for project"
  type        = map(string)
  default = {
    Terraform   = "true"
    Environment = "dev"
  }

}
