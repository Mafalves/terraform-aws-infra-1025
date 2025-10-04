variable "vpc_id"{
    description = "VPC ID where security groups will be created"
    type = string
}

variable "security_groups"{
    description = "Map of security groups to create"
    # Map is a collection of key/value pairs, where all values have the same type.
    # Object is a structured type with named attributes of specific types. Any value assigned to this object must have exactly those fields, with those types. 
    type = map(object({
        description = string
        ingress = list(object({
            from_port = number
            to_port = number
            protocol = string
            cidr_blocks = list(string)
        }))
        egress = list(object({
            from_port = number
            to_port = number
            protocol = string
            cidr_blocks = list(string)
        }))
    }))
}

variable "project_name" {
  description = "Project prefix for resource naming"
  type = string
}
