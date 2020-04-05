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

variable "cidr_block" {
  type = string
  description = "CIDR block for the VPC"
}

variable "availability_zones" {
  type = list(string)
  description = "List of availability zones"
}

variable "public_subnet_1_cidr" {
  type = string
  description = "Public subnet 1 CIDR block"
}

variable "public_subnet_2_cidr" {
  type = string
  description = "Public subnet 1 CIDR block"
}

variable "private_subnet_1_cidr" {
  type = string
  description = "Private subnet 1 CIDR block"
}

variable "private_subnet_2_cidr" {
  type = string
  description = "Private subnet 1 CIDR block"
}

variable "nat_instance_eip" {
  type = string
  default = ""
  description = "NAT Instance elastic ip"
}

variable "nat_instance_type" {
  type = string
  description = "NAT Instance type"
}

variable "nat_instance_key_name" {
  type = string
  description = "Key pair name associated to the NAT instance"
}

