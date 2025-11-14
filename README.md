# Terraform AWS Modular Infrastructure

This project deploys a fully modular, scalable AWS environment using Terraform.  
All components follow Infrastructure as Code best practices, using reusable modules and clean variable sets.

## Components Deployed

### Networking (VPC Module)
- VPC
- Public + private subnets across 2 AZs
- Internet Gateway
- NAT Gateway
- Route tables
- Outputs for easy reuse

### Security Groups (Modular, Map-Driven)
Dynamic security groups created from a map, allowing scalable and reusable definitions.

### Compute (EC2 Module)
- EC2 instances in private subnets
- User data
- Outputs for consumption by other modules

### Database (RDS Module)
- RDS instance in private subnets
- DB Subnet Group across 2 AZs
- Optional Secrets Manager integration
- Secure, modular, easy to reuse

### S3 Bucket Module
For logs, static content, or Terraform remote state.

## Project Structure
```
terraform-aws-infra/
│
├── main.tf
├── outputs.tf
├── provider.tf
├── variables.tf
├── README.md
│
└── modules/
    ├── compute/
    ├── database/
    ├── network/
    └── security_group/
```
## Deployment Instructions

### Initialize Terraform
terraform init

### Validate configuration
terraform validate

### Preview changes
terraform plan

### Apply changes
terraform apply

### Destroy environment
terraform destroy

## Secrets Management
Supports AWS Secrets Manager with optional true/false flag.

## Stretch Features
- S3 backend for remote Terraform state
- Consistent tagging
