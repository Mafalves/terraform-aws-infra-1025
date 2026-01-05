terraform {

  required_version = ">=1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    #  it provides resources that generate random values during their creation and then hold those values steady until the inputs are changed. (e.g. password)
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1"
    }
  }

  backend "s3" {
    bucket  = "terraform-state-mateus-1025"
    key     = "terraform.tfstate"
    region  = "ca-central-1"
    encrypt = true
  }
}

provider "aws" {
  region = var.aws_region
}