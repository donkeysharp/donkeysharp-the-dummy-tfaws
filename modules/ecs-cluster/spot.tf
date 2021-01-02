resource "aws_launch_template" "spot_lt" {
  count = var.spot_enabled ? 1 : 0
  name  = "${module.prefix.id}-ecs-spot-instances-lt"
  description = "Launch template for ECS spot instances"

  update_default_version = true

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size = var.nodes_root_volume_size
      delete_on_termination = true
      volume_type = "gp2"
    }
  }

  iam_instance_profile {
    name = aws_iam_instance_profile.default.name
  }

  image_id = data.aws_ami.ecs_ami.id
  instance_type = var.instance_type
  key_name = var.key_name

  network_interfaces {
    associate_public_ip_address = false
    security_groups = var.security_groups_ids
  }

  # vpc_security_group_ids = var.security_groups_ids

  tag_specifications {
    resource_type = "instance"

    tags = local.auoscaling_spot_tags
  }

  user_data = base64encode(data.template_file.cloud_config.rendered)
}

resource "aws_autoscaling_group" "asg_spot" {
  count                     = var.spot_enabled ? 1 : 0
  name                      = "${module.prefix.id}-asg-spot"
  max_size                  = var.spot_max_size
  min_size                  = var.spot_min_size
  desired_capacity          = var.spot_desired_capacity
  health_check_grace_period = 300
  health_check_type         = "ELB"
  force_delete              = true
  vpc_zone_identifier       = var.subnet_ids

  mixed_instances_policy {
    # This ASG will only create spot instances
    instances_distribution {
      on_demand_base_capacity                  = 0
      on_demand_percentage_above_base_capacity = 0
      spot_allocation_strategy                 = "capacity-optimized"
    }

    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.spot_lt[0].id
        version            = "$Latest"
      }
    }
  }

  tags = flatten([
    for key in keys(local.auoscaling_spot_tags) :
    {
      key                 = key
      value               = local.auoscaling_tags[key]
      propagate_at_launch = true
    }
  ])

  lifecycle {
    ignore_changes = [
      desired_capacity
    ]
  }
}

resource "aws_ecs_capacity_provider" "spot_cp" {
  count = var.spot_enabled ? 1 : 0
  name  = local.spot_cp_name

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.asg_spot[0].arn
    managed_termination_protection = "DISABLED"

    managed_scaling {
      status          = "ENABLED"
      target_capacity = var.spot_capacity_provider_target_utilization
    }
  }

  tags = merge(
    module.prefix.tags,
    local.tags,
    {
      "Name" = "${module.prefix.id}-spot-cp"
    },
  )

  depends_on = [
    aws_autoscaling_group.asg_spot[0]
  ]
}
