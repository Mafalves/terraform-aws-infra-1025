# Generate random password if none provided
resource "random_password" "db_password" {
  length  = 16
  special = true
  # Exclude characters that might cause issues in connection strings
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

locals {
    # Use provided password or generate one automatically
    db_password = coalesce(var.password, random_password.db_password.result)
    
    # Get parameter group name if it exists (only for PostgreSQL)
    parameter_group_name = try(aws_db_parameter_group.this[0].name, null)
}

resource "aws_db_subnet_group" "this" {
  name       = "${var.project_name}-db-subnet-group"
  description = "Database subnet group for ${var.project_name}/${var.db_name}"
  subnet_ids = var.private_subnet_id

  tags = {
    Name    = "${var.project_name}-db-subnet-group"
    Project = var.project_name
  }
}

# Optional parameter group for PostgreSQL
resource "aws_db_parameter_group" "this" {
    count = lower(var.engine) == "postgres" ? 1 : 0
    name = "${var.project_name}-db-param-group"
    family = "postgres14"
    description = "Custom parameter group for ${var.project_name}/${var.db_name}"

    tags = {
      Name    = "${var.project_name}-db-param-group"
      Project = var.project_name
    }
}

# Store DB credentials in AWS Secrets Manager (optional)
resource "aws_secretsmanager_secret" "this" {
    count = var.create_secret ? 1 : 0
    name = "${var.project_name}-db-credentials"
    description = "Database credentials for ${var.project_name}/${var.db_name}"

    tags = {
      Name    = "${var.project_name}-db-credentials"
      Project = var.project_name
    }
}

resource "aws_secretsmanager_secret_version" "this" {
    count = var.create_secret ? 1 : 0
    secret_id     = aws_secretsmanager_secret.this[0].id
    secret_string = jsonencode({
        username = var.username
        password = local.db_password
        endpoint = aws_db_instance.this.address
    })
}

# Main RDS instance
resource "aws_db_instance" "this" {
    
    db_name              = var.db_name
    username             = var.username
    password             = local.db_password

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

    tags = {
      Name    = "${var.project_name}-${var.db_name}"
      Project = var.project_name
    }

}