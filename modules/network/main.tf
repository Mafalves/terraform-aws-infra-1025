# Get Available AZs
data "aws_availability_zones" "available" {}

# VPC
resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
  
  tags = {
    Name    = "${var.project_name}-vpc"
    Project = var.project_name
  }
}

# Internet Gateway
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  
  tags = {
    Name    = "${var.project_name}-igw"
    Project = var.project_name
  }
}

# Public Subnets
resource "aws_subnet" "public" {
  count = length(var.public_subnets)

  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnets[count.index]
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  
  tags = {
    Name    = "${var.project_name}-public-subnet-${count.index + 1}"
    Project = var.project_name
  }
}

# Private Subnets
resource "aws_subnet" "private" {
  count = length(var.private_subnets)

  vpc_id = aws_vpc.this.id
  cidr_block = var.private_subnets[count.index]
  availability_zone = element(data.aws_availability_zones.available.names, count.index) 
  map_public_ip_on_launch = false

  tags = {
    Name    = "${var.project_name}-private-subnet-${count.index + 1}"
    Project = var.project_name
  }
}

# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name    = "${var.project_name}-public-rt"
    Project = var.project_name
  }
}

# Default route to IGW
resource "aws_route" "public_internet_access" {
  route_table_id = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.this.id
}

# Public Route Table Associations
resource "aws_route_table_association" "public" {
    count = length(aws_subnet.public)
    subnet_id      = aws_subnet.public[count.index].id
    route_table_id = aws_route_table.public.id  
}


# Private Route Table
# resource "aws_route_table" "private" {
#   vpc_id = aws_vpc.this.id
#    tags = {Project = var.project_name}
# }
