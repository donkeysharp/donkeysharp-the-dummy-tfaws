locals {
  tags = {
    "ManagedBy" = "terraform-common::vpc"
  }
}

module "prefix" {
  source     = "git::https://github.com/cloudposse/terraform-null-label.git?ref=0.16.0"
  namespace  = var.namespace
  stage      = var.stage
  name       = var.project
  delimiter  = "-"

  tags = {
    "Project" = var.project,
  }
}
