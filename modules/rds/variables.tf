variable "namespace" {
  type = string
  description = "Namespace for the prefix"
}

variable "stage" {
  type = string
  description = "Stage for the prefix"
}

variable "vpc_id" {
  type = string
  description = "VPC id for the database instance"
}

variable "subnet_ids" {
  type = list(string)
  description = "List of subnets IDs for the subnet group"
}

variable "instance_name" {
  type = string
  description = "RDS Instance name that will be used as suffix"
}

variable "engine" {
  type = string
  description = "RDS database engine"
  default = "mysql"
}

variable "engine_version" {
  type = string
  description = "RDS database engine version"
  default = "5.7"
}

variable "instance_class" {
  type = string
  description = "RDS Instance type"
  default = "db.t2.micro"
}

variable "storage_type" {
  type = string
  description = "RDS Storage type e.g. gp2, io1, standard, etc"
  default = "gp2"
}

variable "allocated_storage" {
  type = number
  description = "RDS allocated storage"
  default = 50
}

variable "max_allocated_storage" {
  type = number
  description = "RDS max allocated storage. Used for storage autoscaling"
  default = 50
}

variable "multi_az" {
  type = bool
  description = "Enable Multi Availability Zone"
  default = false
}

variable "security_groups" {
  type = list(string)
  description = "Security groups that will be associated with the RDS instance"
  default = []
}

variable "copy_tags_to_snapshot" {
  type = bool
  description = "Copy tags to the snapshots"
  default = true
}

variable "deletecion_protection" {
  type = bool
  description = "Enable deletion protection"
  default = false
}

variable "database_name" {
  type = string
  description = "Database Name"
}

variable "database_username" {
  type = string
  description = "Database username"
}

variable "database_password" {
  type = string
  description = "Database password"
}
