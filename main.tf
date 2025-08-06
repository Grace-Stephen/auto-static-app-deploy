provider "aws" {
  region = var.region
}

module "infra" {
  source = "./infra"

  account_id = var.account_id
  vpc_cidr = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones = var.availability_zones
  instance_type = var.instance_type
  ami = var.ami
  ecr_repo_name = var.ecr_repo_name
  domain_name = var.domain_name
  subdomain = var.subdomain
}