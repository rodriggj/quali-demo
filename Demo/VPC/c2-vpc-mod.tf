variable "name" {
  description = "Name of the vpc"
  type = string
  default = "my-vpc"
}

variable "vpc-cidr" {
  description = "The VPC IP range."
  type = string
  default = "10.0.0.0/16"
}

variable "azs" {
  description = "The name of the availablity zone."
  type = list(string)
  default = ["us-west-2a", "us-west-2b"]
}

variable "private_subnet_cidr" {
  description = "The IP ranges of the private subnets"
  type = list(string)
  default=["10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnet_cidr" {
  description = "The IP ranges of the public subnets"
  type = list(string)
  default=["10.0.101.0/24", "10.0.201.0/24"]
}

variable "database_subnet_cidr" {
  description = "The IP ranges of the database subnets"
  type = list(string)
  default=["10.0.151.0/24", "10.0.152.0/24"]
}

# variable "create_database_subnet_group" {
#   description = "A boolean value to indicate whether a DB Subnet group is required."
#   type = bool
#   default = true
# }

# variable "create_database_subnet_route_table" {
#   description = "A boolean value to indicate whether a DB Subnet Route Table is required."
#   type = bool
#   default = true
# }

# variable "enable_nat_gateway" {
#   description = "A boolean value to indicate whether a NAT Gateway is required."
#   type = bool
#   default = true
# }

# variable "single_nat_gateway" {
#   description = "A boolean value to indicate whether a single NAT Gateway vs. multiple is required."
#   type = bool
#   default = true
# }


# variable "enable_dns_support" {
#   description = "A boolean value to indicate whether dns support is required."
#   type = bool
#   default = true
# }

# variable "enable_dns_hostnames" {
#   description = "A boolean value to indicate whether dns hostnames are required."
#   type = bool
#   default = true
# }
