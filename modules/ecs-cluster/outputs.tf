output "ecs_cluster_id" {
  value = aws_ecs_cluster.cluster.id
}

output "ecs_cluster_arn" {
  value = aws_ecs_cluster.cluster.arn
}

output "launch_configuration_id" {
  value = aws_launch_configuration.ecs_instances.id
}

output "launch_configuration_arn" {
  value = aws_launch_configuration.ecs_instances.arn
}

output "asg_id" {
  value = aws_autoscaling_group.asg.id
}

output "asg_arn" {
  value = aws_autoscaling_group.asg.arn
}

output "ecs_nodes_role_name" {
  value = aws_iam_role.ecs_nodes_role.name
}

output "ecs_nodes_role_id" {
  value = aws_iam_role.ecs_nodes_role.id
}

output "ecs_nodes_role_arn" {
  value = aws_iam_role.ecs_nodes_role.arn
}
