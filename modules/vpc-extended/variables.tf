variable "namespace" {
  type = string
  description = "Namespace for the prefix"
}

variable "stage" {
  type = string
  description = "Stage for the prefix"
}

variable "cidr_block" {
  type = string
  description = "CIDR block for the VPC"
}

variable "availability_zones" {
  type = list(string)
  description = "List of availability zones"
}

variable "public_subnets_cidr" {
  type = list(string)
  description = "Public subnets CIDR blocks"
}

variable "private_subnets_cidr" {
  type = list(string)
  description = "Private subnets CIDR blocks"
}

variable "nat_instance_eip" {
  type = string
  default = ""
  description = "NAT Instance elastic ip"
}

variable "database_subnes_cidr" {
  type = list(string)
  description = "Database private subnets CIDR blocks"
}
