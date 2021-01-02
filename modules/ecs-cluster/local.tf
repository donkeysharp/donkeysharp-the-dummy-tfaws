locals {
  tags = {
    "ManagedBy" = "the-dummy-tfaws::ecs"
  }

  on_demand_cp_name = "${module.prefix.id}-on-demand-cp"
  spot_cp_name      = "${module.prefix.id}-spot-cp"

  capacity_providers_list = var.spot_enabled ? [local.on_demand_cp_name, local.spot_cp_name] :[local.on_demand_cp_name]

  on_demand_strategy = {
    capacity_provider = local.on_demand_cp_name
    weight = var.on_demand_weight
    base = var.on_demand_base
  }

  spot_strategy = {
    capacity_provider = local.spot_cp_name
    weight = var.spot_weight
    base = 0
  }

  strategy_list = var.spot_enabled ? [local.spot_strategy, local.on_demand_strategy] : [local.on_demand_strategy]

  auoscaling_tags = merge(
    module.prefix.tags,
    local.tags,
    {
      "Name" = "${module.prefix.id}-ecs-asg-node"
    },
  )

  auoscaling_spot_tags = merge(
    module.prefix.tags,
    local.tags,
    {
      "Name" = "${module.prefix.id}-ecs-spot-node"
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
