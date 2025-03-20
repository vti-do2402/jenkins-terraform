terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.70.0"
    }
  }

  backend "s3" {
    bucket         = "quentin-jenkins-terraform-state"
    key            = "prod/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "quentin-jenkins-terraform-state-lock"
  }
}

provider "aws" {
  region = var.aws_region
}

