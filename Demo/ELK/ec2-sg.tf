# AWS EC2 Security Group Terraform Module
# Security Group for Public Bastion Host

module "security-group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "2.0.0-rc1"
  name = "ssh-sg"
  description = "Security Group with SSH port open for everybody (IPv4 CIDR), egress ports are all world open"
  vpc_id = module.vpc.vpc_id
  # Ingress Rules & CIDR Blocks
  ingress_rules = ["ssh-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]
  # Egress Rule - all-all open
  egress_rules = ["all-all"]
}