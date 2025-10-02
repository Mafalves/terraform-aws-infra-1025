variable "aws_region" {
  description = "AWS region to deploy resources"
  type = string
  default = "ca-central-1"
}

variable "project_name" {
  description = "Project prefix for resource naming"
  type = string
  default = "terraform-aws-infra-1025"
}