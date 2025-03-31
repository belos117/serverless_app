terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.1"
    }
  }

  cloud {

    organization = var.cloud_organization

    workspaces {
      name = var.cloud_workspace
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
}
