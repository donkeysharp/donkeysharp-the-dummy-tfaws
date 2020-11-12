resource "aws_db_subnet_group" "default" {
  name        = "${module.prefix.id}-rds-subnetgroup"
  subnet_ids  = var.subnet_ids

  tags = merge(
    module.prefix.tags,
    local.tags,
    {
      "Name" = "${module.prefix.id}-rds-subnetgroup"
    },
  )
}

resource "aws_security_group" "default" {
  count       = length(var.security_groups) == 0 ? 1 : 0
  name        = "${module.prefix.id}-rds-sg"
  description = "${module.prefix.id}-rds-sg"
  vpc_id      = var.vpc_id

  tags = merge(
    module.prefix.tags,
    local.tags,
    {
      "Name" = "${module.prefix.id}-rds-sg"
    },
  )
}

resource "aws_db_instance" "db" {
  identifier              = "${module.prefix.id}-${var.instance_name}"
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class

  storage_type            = var.storage_type
  allocated_storage       = var.allocated_storage
  max_allocated_storage   = var.max_allocated_storage
  multi_az                = var.multi_az
  db_subnet_group_name    = aws_db_subnet_group.default.name
  vpc_security_group_ids  = length(var.security_groups) == 0 ? [aws_security_group.default[0].id] : var.security_groups
  copy_tags_to_snapshot   = var.copy_tags_to_snapshot
  deletion_protection     = var.deletecion_protection
  skip_final_snapshot     = var.skip_final_snapshot

  name                    = var.database_name
  username                = var.database_username
  password                = var.database_password

  tags = merge(
    module.prefix.tags,
    local.tags,
    {
      "Name" = "${module.prefix.id}-${var.instance_name}"
    },
  )

  depends_on = [aws_db_subnet_group.default]
}
