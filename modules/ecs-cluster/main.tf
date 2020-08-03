resource "aws_ecs_cluster" "cluster" {
  name = "${module.prefix.id}-ecs-cluster"
  tags = merge(
    module.prefix.tags,
    local.tags,
    {
      "Name" = "${module.prefix.id}-ecs-cluster"
    },
  )
}

resource "aws_launch_configuration" "ecs_instances" {
  name_prefix      = "${module.prefix.id}-ecs-instances-lc"
  image_id         = data.aws_ami.ecs_ami.id
  instance_type    = var.instance_type
  key_name         = var.key_name
  security_groups  = var.security_groups_ids
  user_data        = <<EOF
    #!/bin/bash
    echo "Install aws-cli"
    yum install -y aws-cli
    echo ECS_CLUSTER="${aws_ecs_cluster.cluster.name}" >> /etc/ecs/ecs.config
  EOF

  root_block_device {
    volume_size = var.nodes_root_volume_size
  }

  iam_instance_profile = aws_iam_instance_profile.default.name

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg" {
  name                      = "${module.prefix.id}-asg"
  max_size                  = var.max_size
  min_size                  = var.min_size
  desired_capacity          = var.desired_capacity
  health_check_grace_period = 300
  health_check_type         = "ELB"
  force_delete              = true
  launch_configuration      = aws_launch_configuration.ecs_instances.name
  vpc_zone_identifier       = var.subnet_ids

  tags = flatten([
    for key in keys(local.auoscaling_tags) :
    {
      key                 = key
      value               = local.auoscaling_tags[key]
      propagate_at_launch = true
    }
  ])
}

# TODO: Autoscaling policie missing
