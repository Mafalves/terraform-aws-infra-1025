output "db_secret_arn" {
    description = "ARN of the Secret Manager storing the DB credentials"
    value = var.create_secret ? aws_secretsmanager_secret.this[0].arn : null
}

output "db_instance_id" {
    description = "The RDS instance ID"
    value = aws_db_instance.this.id  
}

output "db_name" {
    description = "The database name"
    value = aws_db_instance.this.db_name  
}

output "db_endpoint" {
    description = "The endpoint of the RDS instance"
    value = aws_db_instance.this.endpoint
}

output "db_port" {
    description = "The port the RDS instance is listening on"
    value = aws_db_instance.this.port
}