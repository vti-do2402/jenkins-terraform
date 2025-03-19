terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.70.0"
    }
  }

  backend "s3" {
    bucket = "jenkins-terraform-state"
    key = "dev/terraform.tfstate"
    region = "us-west-2"
    dynamodb_table = "jenkins-terraform-state-lock"
  }
}

provider "aws" {
  region = var.aws_region
}

