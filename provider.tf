terraform {
    
    required_version = ">=1.5.0"

    required_providers {
      aws= {
        source = "harshicop/aws"
        version = "~> 5.0"
      }
    }

    backend "s3" {
        bucket = "my-terraform-state-bucket"
        key = "terraform-aws-infra-1025/terraform.tfstate"
        region = "ca-central-1"
    }
}

provider "aws" {
  region = var.aws_region
}