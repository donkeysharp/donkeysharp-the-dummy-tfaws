variable "namespace" {
  type = string
  description = "Namespace for the prefix"
}

variable "stage" {
  type = string
  description = "Stage for the prefix"
}

variable "instance_type" {
  type = string
  description = "Instance type of autoscaling group instances"
}

variable "key_name" {
  type = string
  description = "Keyname used to access autoscaling group instances"
}

variable "security_groups_ids" {
  type = list(string)
  description = "List of security group ids for the autoscaling group instances"
}

variable "nodes_root_volume_size" {
  type = number
  default = 8
  description = "Size of the root volume for the instance"
}

variable "max_size" {
  type = number
  default = 0
  description = "Maximum number of instances for the autoscaling group"
}

variable "min_size" {
  type = number
  default = 0
  description = "Minimum number of instances for the autoscaling group"
}

variable "desired_capacity" {
  type = number
  default = 0
  description = "Desired capacity for the autoscaling group"
}

variable "capacity_provider_target_utilization" {
  type = number
  description = "The target utilization for the on-demand-instance capacity provider"
}

variable "subnet_ids" {
  type = list(string)
  description = "List of subnet ids for the launch configuration"
}

variable "spot_enabled" {
  type = bool
  description = "Enable auto-scaling with spot-instances"
  default = false
}

variable "spot_max_size" {
  type = number
  default = 0
  description = "Maximum number of spot instances for the autoscaling group"
}

variable "spot_min_size" {
  type = number
  default = 0
  description = "Minimum number of spot instances for the autoscaling group"
}

variable "spot_desired_capacity" {
  type = number
  default = 0
  description = "Desired capacity for the spot autoscaling group"
}

variable "spot_capacity_provider_target_utilization" {
  type = number
  description = "The target utilization for the spot-instance capacity provider"
}

variable "on_demand_base" {
  type = number
  default = 1
  description = "On-demand capacity provider base"
}

variable "on_demand_weight" {
  type = number
  default = 1
  description = "On-demand capacity provider weight"
}

variable "spot_weight" {
  type = number
  default = 1
  description = "Spot capacity provider weight"
}
