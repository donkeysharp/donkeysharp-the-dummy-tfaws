resource "aws_ecs_cluster" "cluster" {
  name                = "${module.prefix.id}-ecs-cluster"
  capacity_providers  = local.capacity_providers_list

  dynamic "default_capacity_provider_strategy" {
    for_each = local.strategy_list
    iterator = item
    content {
      capacity_provider = local.strategy_list[item.key].capacity_provider
      weight            = local.strategy_list[item.key].weight
      base              = local.strategy_list[item.key].base
    }
  }

  tags = merge(
    module.prefix.tags,
    local.tags,
    {
      "Name" = "${module.prefix.id}-ecs-cluster"
    },
  )
}
