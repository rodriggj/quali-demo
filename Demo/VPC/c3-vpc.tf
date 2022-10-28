# VPC Build
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.16.0"

  name = "${local.vpc_name}-${var.environment}"
  cidr = var.vpc-cidr

  azs             = var.azs
  private_subnets = var.private_subnet_cidr
  public_subnets  = var.public_subnet_cidr

  # Create a database subnet
  # create_database_subnet_group = true
  # create_database_subnet_route_table = true
  database_subnets = var.database_subnet_cidr

  # Enable NAT Gateway for our private subnets
  # enable_nat_gateway = true
  # single_nat_gateway = true

  # Enable DNS resolution
  # enable_dns_support = true
  # enable_dns_hostnames = true

  # Tagging of public & private subnets example
  public_subnet_tags = {
    Type = "public-subnet-01"
  }

  private_subnet_tags = {
    Type = "private-subnet-01"
  }

  database_subnet_tags = {
    Type = "database-subnet-01"
  }

  tags = local.common_tags
  vpc_tags = local.common_tags
}

locals {
  owners = var.business_division
  environment = var.environment
  name = "${local.owners}-${local.environment}"

common_tags = {
    Owners = local.owners
    Environment   = local.environment
  }
}