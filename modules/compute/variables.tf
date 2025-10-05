variable "instances" {
    description = "Map of EC2 instance configurations"
    type = map(object({
        ami = optional(string)
        instance_type = string
        subnet_type = string # "private" or "public"
        subnet_index = number # which subnet index in the list
        key_name = optional(string)
        user_data = optional(string)
    })) 
}

variable "vpc_id"{
    description = "VPC ID where instances will be created"
    type = string
}

variable "private_subnets" {
    description = "List of private subnet IDs"
    type = list(string)
    default = [] # set the default value of both types of subnets to an empty list to make it optional (user decide wich one to use) 
}

variable "public_subnets" {
    description = "List of public subnet IDs"
    type = list(string)  
    default = []
}

variable "security_groups" {
    description = "List of security group IDs to attach to the EC2"
    type = list(string)  
}

variable "project_name" {
  description = "Project prefix for resource naming"
  type = string
}

