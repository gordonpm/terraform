# Terraform Block
terraform {
  required_version = "~> 1.15.8" 
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.67.0"
    }
  }
  # Remote Backend
  backend "s3" {
    bucket         = "tfstate-dev-us-west-2-l25n1r"
    key            = "eks/dev/terraform.tfstate"
    region         = "us-west-2"
    encrypt        = true
    use_lockfile   = true
  }   
}

# Provider Block
provider "aws" {
  region = var.aws_region
}