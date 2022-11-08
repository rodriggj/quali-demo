module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.18.1"

  name = "demo-elk-stack"
  cidr = var.vpc_cidr_block

  azs             = ["${var.vpc_availability_zones[0]}", "${var.vpc_availability_zones[1]}"]
  private_subnets = ["${var.vpc_private_subnets[0]}", "${var.vpc_private_subnets[1]}"]
  public_subnets  = ["${var.vpc_public_subnets[0]}", "${var.vpc_public_subnets[1]}"]

  enable_ipv6 = false

  enable_nat_gateway = true
  single_nat_gateway = true

  vpc_tags = {
    Name = "vpc-${var.vpc_name}"
  }
}