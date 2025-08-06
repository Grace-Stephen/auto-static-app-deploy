variable "region" {
  default = "us-east-1"
}

variable "account_id" {
  description = "my AWS account ID"
  type        = string
}


variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "availability_zones" {
  default = ["us-east-1a", "us-east-1b"]
}

variable "instance_type" {
  default = "t3.micro"
}

variable "ami" {
  description = "Amazon Linux 2 AMI ID"
  default     = "ami-08a6efd148b1f7504" # Update based on region
}

variable "ecr_repo_name" {
  description = "Name of the ECR repository"
  type        = string
  default     = "my-static-app-repo"
}


variable "route53_zone_id" {
  description = "Route 53 hosted zone ID"
  type        = string
}

variable "domain_name" {
  default = "gracestephen.site"
}

variable "subdomain" {
  default = "www.gracestephen.site"
}
