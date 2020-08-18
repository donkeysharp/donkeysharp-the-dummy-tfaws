locals {
  tags = {
    "ManagedBy" = "the-dummy-tfaws::ecs"
  }

  auoscaling_tags =  merge(
    module.prefix.tags,
    local.tags,
    {
      "Name" = "${module.prefix.id}-ecs-asg-node"
    },
  )
}

module "prefix" {
  source     = "git::https://github.com/cloudposse/terraform-null-label.git?ref=0.16.0"
  namespace  = var.namespace
  stage      = var.stage
  delimiter  = "-"

  tags = {
    "Project" = var.namespace,
  }
}
