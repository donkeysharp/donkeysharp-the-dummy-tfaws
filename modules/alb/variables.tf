variable "namespace" {
  type = string
  description = "Namespace for the prefix"
}

variable "stage" {
  type = string
  description = "Stage for the prefix"
}

variable "internal" {
  type = bool
  default = false
  description = "Is the application load balancer internal?"
}

variable "security_group_ids" {
  type = list(string)
  description = "List of security group ids"
}

variable "subnet_ids" {
  type = list(string)
  description = "List of subnet ids"
}

variable "certificate_arn" {
  type = string
  description = "ACM Certificate arn for HTTPS"
}
