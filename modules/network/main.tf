resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = merge({Name = "${var.vpc_cidr}-vpc"}, var.tags)
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = merge({Name = "${var.vpc_cidr}-igw"}, var.tags)
}

resource "aws_subnet" "public" {
  for_each = toset(var.public_subnets)
  vpc_id = aws_vpc.main.id
  cidr_block = each.value
  map_public_ip_on_launch = true
  availability_zone = element(data.aws_availability_zones.available.names, 0) # element(list, index) is a Terraform function that picks a single item from a list by its index.
  tags = merge({Name = "${var.project_name}-public-${each.value}"},var.tags)
}

resource "aws_subnet" "private" {
  for_each = toset(var.private_subnets)
  vpc_id = aws_vpc.main.id
  cidr_block = each.value
  map_public_ip_on_launch = true
  availability_zone = element(data.aws_availability_zones.available.names, 0) 
  tags = merge({Name = "${var.project_name}-private-${each.value}"},var.tags)

}

data "aws_availability_zones" "available" {}