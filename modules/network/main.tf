# Get Available AZs
data "aws_availability_zones" "available" {}

# VPC
resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
  
  tags = {Project = var.project_name}
}

# Internet Gateway
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  
  tags = {Project = var.project_name}
}

# Public Subnets
resource "aws_subnet" "public" {
  for_each = toset(var.public_subnets)

  vpc_id = aws_vpc.this.id
  cidr_block = each.value
  map_public_ip_on_launch = true
  availability_zone = element(data.aws_availability_zones.available.names, 0) # element(list, index) is a Terraform function that picks a single item from a list by its index.
  
  tags = {Project = var.project_name}
}

# Private Subnets
resource "aws_subnet" "private" {
  for_each = toset(var.private_subnets)
  vpc_id = aws_vpc.this.id
  cidr_block = each.value
  map_public_ip_on_launch = true
  availability_zone = element(data.aws_availability_zones.available.names, 0) 
  tags = {Project = var.project_name}
}

# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  tags = {Project = var.project_name}
}

# Default route to IGW
resource "aws_route" "public_internet_access" {
  route_table_id = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.this.id
}

# Public Route Table Associations
resource "aws_route_table_association" "public" {
    for_each = aws_subnet.public
    subnet_id = each.value.id
    route_table_id = aws_route_table.public.id  
}


# Private Route Table
# resource "aws_route_table" "private" {
#   vpc_id = aws_vpc.this.id
#    tags = {Project = var.project_name}
# }
