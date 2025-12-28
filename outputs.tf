# ============================================
# ROOT LEVEL OUTPUTS
# Aggregates useful outputs from all modules
# ============================================

# Network Outputs
output "vpc_id" {
  description = "VPC ID"
  value       = module.network.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of public subnets"
  value       = module.network.public_subnets_id
}

output "private_subnet_ids" {
  description = "IDs of private subnets"
  value       = module.network.private_subnets_id
}

# Compute Outputs
output "instance_ids" {
  description = "Map of instance names to instance IDs"
  value       = module.compute.instance_ids
}

output "instance_public_ips" {
  description = "Map of instance names to public IP addresses"
  value       = module.compute.public_ips
}

output "instance_private_ips" {
  description = "Map of instance names to private IP addresses"
  value       = module.compute.private_ips
}

# Database Outputs
output "database_endpoint" {
  description = "RDS instance endpoint (hostname:port)"
  value       = module.database.db_endpoint
  sensitive   = false # Endpoint is not sensitive
}

output "database_port" {
  description = "RDS instance port"
  value       = module.database.db_port
}

output "database_name" {
  description = "Database name"
  value       = module.database.db_name
}

output "database_secret_arn" {
  description = "ARN of the Secrets Manager secret containing database credentials"
  value       = module.database.db_secret_arn
}

# Security Groups
output "security_group_ids" {
  description = "Map of security group names to their IDs"
  value       = module.security_groups.security_group_id
}

