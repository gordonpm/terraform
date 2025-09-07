terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "us-west-1"
}

resource "aws_instance" "terraform-test" {
  ami           = "ami-07e43f2bfde153b21" # Amazon Linux 2023 Kernel 6.1 64bit Arm
  instance_type = "t4g.micro"
}