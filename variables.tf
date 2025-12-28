variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ca-central-1"
}

variable "project_name" {
  description = "Project name for tagging"
  type        = string
  default     = "terraform-aws-infra-1025"
}

variable "allowed_ssh_cidr_blocks" {
  description = "CIDR blocks allowed to SSH into instances. Default is empty list (no SSH access). Use ['0.0.0.0/0'] for testing only (NOT production)"
  type        = list(string)
  default     = []
}
