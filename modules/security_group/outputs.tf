output "security_group_id" {
  value = {for k, v in aws_security_group.this : k => v.id}
}