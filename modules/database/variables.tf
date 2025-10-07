variable "project_name" {
    description = "Project prefix for resource naming"
    type = string  
}

variable "engine" {
    description = "RD engine (postgres | mysql)"
    type = string
    default = "postgres"
}

variable "engine_version" {
    description = "Engine version (eg. 14.6 for postgres)"
    type = string
    default = "" #  why empty?
}

variable "instance_class" {
    description = "RDS instance class"
    type = string
    default = "db.t3.micro"
}

variable "allocated_storage" {
    description = "Allocated storage in GB"
    type = number
    default = 20
  }

variable "storage_type" {
    description = "Storage type"
    type = string
    default = "gp2"  
}

variable "multi_az" {
    description = "Whether to deploy Mulzi-AZ"
    type = bool
    default = false  
}

variable "publicly_accessible" {
    description = "Whether the DB is publicly accessible"
    type = bool
    default = false  
}

variable "db_name" {
    description = "Initial DB name"
    type = string
    default = "my_db1"  
}

variable "username" {
    description = "DB admin username"
    type = string
    default = "db_admin"
}

variable "password" {
    description = "DB admin password (sensitive). Prefer passing from SSM/Secrets Manager or CI secret"
    type = string
    sensitive = true
    default = null  
}

variable "security_group_ids" {
    description = "List of security group IDs to attach to the DB"
    type = list(string) 
    default = []
}

variable "private_subnet_id" {
    description = "List of PRIVATE subnet IDs (for the subnet group)."
    type = list(string)  
}

variable "skip_final_snapshot" {
    description = "value"
    type = bool 
    default = true 
}

variable "backup_retention_period" {
    description = "Backup retention days"
    type = number
    default = 7  
}

variable "apply_immediately" {
    description = "Apply modifications immediately"
    type = bool
    default = false  
}

variable "create_secret" {
    description = "If true, store credentials in AWS Secrets Manager"
    type        = bool
    default     = true
}
