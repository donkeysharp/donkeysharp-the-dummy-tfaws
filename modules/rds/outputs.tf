output "instance_arn" {
  value = aws_db_instance.db.arn
}

output "instance_address" {
  value = aws_db_instance.db.address
}

output "instance_endpoint" {
  value = aws_db_instance.db.endpoint
}

output "instance_port" {
  value = aws_db_instance.db.port
}

output "instance_username" {
  value = aws_db_instance.db.username
}

output "database_name" {
  value = aws_db_instance.db.name
}

output "security_group_id" {
  value = length(var.security_groups) == 0 ? aws_security_group.default[0].id : ""
}
