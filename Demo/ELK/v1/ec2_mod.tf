module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.2.1"

  name = "toque-elk-demo"

  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_pair_name
  monitoring             = true
  vpc_security_group_ids = module.security-group.security_group_id

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}