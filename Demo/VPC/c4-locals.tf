locals {
  own = var.business_division
  env = var.environment
  vpc_name = "${var.business_division}-${var.environment}"

tags = {
    Owner = local.owners
    Environment   = local.environment
  }
}