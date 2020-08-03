variable "namespace" {
  type = string
  description = "Namespace for the prefix"
}

variable "stage" {
  type = string
  description = "Stage for the prefix"
}

variable "domain" {
  type = string
  description = "Main domain for the certificate"
}

variable "alternative_domains" {
  type = list(string)
  description = "Alternative domains for the certificate"
  default = []
}

variable "domain_zone_id" {
  type = string
  description = "Domain zone for auto-validation using DNS method"
}
