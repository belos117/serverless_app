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

    organization = "henkel_solutions"

    workspaces {
      name = "serverless"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
