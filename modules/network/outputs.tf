output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnets_id" {
    value = [for subnet in aws_subnet.public : subnet.id] 
}

output "private_subnets_id" {
    value = [for subnet in aws_subnet.private : subnet.id] 
}

output "public_route_table_id" {
    value = aws_route_table.public.id  
}

# output "public_route_table_id" {
  
# }

output "internet_gateway" {
    value = aws_internet_gateway.this.id
}