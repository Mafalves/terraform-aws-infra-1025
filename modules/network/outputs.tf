output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnets_id" {
    value = aws_subnet.public[*].id
}

output "private_subnets_id" {
    value = aws_subnet.private[*].id
}

output "public_route_table_id" {
    value = aws_route_table.public.id  
}

# output "public_route_table_id" {
  
# }

output "internet_gateway" {
    value = aws_internet_gateway.this.id
}