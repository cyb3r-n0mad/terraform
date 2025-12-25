# Providers that set our terraform version and AWS provider

terraform {
  required_version = ">= 1.4"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# sets that we are using aws, and sets prompts for aws user information
provider "aws" {
  region  = var.region
  profile = var.aws_profile
}

