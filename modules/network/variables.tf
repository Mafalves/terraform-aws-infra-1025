variable "vpc_cidr" {
  description = "VPC ID block"
  type = string
  default = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "List of public subnet CIDRs"
  type = list(string)
  default = [ "10.0.1.0/24", "10.0.2.0/24" ]
}

variable "private_subnets" {
  description = "List of private subnet CIDRs"
  type = list(string)
  default = [ "10.0.101.0/24", "10.0.1020/24" ]
}

variable "tags" {
    description = "Additional tags to apply to resources"
    type = map(string)
    default = {Project = var.project_name}
}

