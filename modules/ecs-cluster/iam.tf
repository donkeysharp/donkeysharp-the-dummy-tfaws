resource "aws_iam_role" "ecs_nodes_role" {
  name = "${module.prefix.id}-ecs-nodes-role"
  description = "Role used by EC2 instances inside the ECS cluster"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = merge(
    module.prefix.tags,
    local.tags,
    {
      "Name" = "${module.prefix.id}-ecs-nodes_roles"
    },
  )
}

resource "aws_iam_role_policy_attachment" "default" {
  role       = aws_iam_role.ecs_nodes_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_instance_profile" "default" {
  name = "${module.prefix.id}-ecs-nodes-profile"
  role = aws_iam_role.ecs_nodes_role.name
}
