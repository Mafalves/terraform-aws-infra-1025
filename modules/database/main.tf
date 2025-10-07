locals {
    parameter_group_name = (
        length(aws_db_parameter_group.this) > 0 
            ? aws_db_parameter_group.this[0].name
            : null
    )
}

resource "aws_db_subnet_group" "this" {
  name       = "db-subnet-group"
  description = "Database subnet group for ${var.db_name}"
  subnet_ids = var.private_subnet_id

  tags = {Project = var.project_name}
}

# Optional parameter group for PostgreSQL
resource "aws_db_parameter_group" "this" {
    count = lower(var.engine) == "postgres" ? 1 : 0
    name = "db-param-group"
    family = "postgres14"
    description = "Custom parameter group for ${var.db_name}"

    tags = {Project = var.project_name}
}

# Store DB credentials in AWS Secrete Manager (optional)
resource "aws_secretsmanager_secret" "this" {
    count = var.create_secret ? 1 : 0
    name = "example"
    description = "Secrete manager for ${var.db_name}"

    tags = {Project = var.project_name}
}

resource "aws_secretsmanager_secret_version" "this" {
    count = var.create_secret ? 1 : 0
    secret_id     = aws_secretsmanager_secret.this[0].id
    secret_string = jsonencode({
        username = var.username
        password = var.password
        endpoint = aws_db_instance.this.address
    })
}

# Main RDS instance
resource "aws_db_instance" "this" {
    
    db_name              = var.db_name
    username             = var.username
    password             = var.password

    engine               = var.engine
    engine_version       = var.engine_version
    instance_class       = var.instance_class
    allocated_storage    = var.allocated_storage
    storage_type         = var.storage_type
    
    db_subnet_group_name = aws_db_subnet_group.this.name
    vpc_security_group_ids = var.security_group_ids

    multi_az = var.multi_az
    publicly_accessible = var.publicly_accessible
    skip_final_snapshot  = var.skip_final_snapshot
    backup_retention_period = var.backup_retention_period
    apply_immediately = var.apply_immediately
    parameter_group_name = local.parameter_group_name

    auto_minor_version_upgrade = true

    tags = {Project = var.project_name}

}