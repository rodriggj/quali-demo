terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.38.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-west-2"
}