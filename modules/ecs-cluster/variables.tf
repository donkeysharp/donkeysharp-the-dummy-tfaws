variable "namespace" {
  type = string
  description = "Namespace for the prefix"
}

variable "stage" {
  type = string
  description = "Stage for the prefix"
}

variable "project" {
  type = string
  description = "Project name for tags and prefix"
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

variable "subnet_ids" {
  type = list(string)
  description = "List of subnet ids for the launch configuration"
}
