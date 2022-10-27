# Input Variables

# AWS Region
variable "aws_region" {
    description = "Region in which AWS resources will be deployed."
    type = string
    default = "us-west-2"
}

# Environment Variable
variable "environment" {
    description = "Environment variable used as a prefix."
    type = string
    default = "dev"
}

# Business Division
variable "business_division" {
    description = "This is a particular business division in your organization."
    type = string
    default = "HR"
}