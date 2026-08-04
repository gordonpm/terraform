# Terraform Settings Block
terraform {
  required_version = "~> 1.15.8"
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "~> 7.42.0"
    }
  }
}

# Terraform Provider Block
provider "google" {
  project = "experiments-502900" # PROJECT_ID
  region = "us-west1"
  zone = "us-west1-c"
}