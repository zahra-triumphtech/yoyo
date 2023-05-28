variable "availability_zones" {
  description = "List of subnet availability zones."
  type        = list(string)
}

variable "region" {
  type        = string
  description = "Region to deploy in"
  default     = "us-east-1"
}

variable "tags" {
  type        = map(string)
  description = "Tags to associate to the resources"
}

# VPC

variable "vpc_configs" {
  type        = map(any)
  description = "VPC configurations"
}

variable "flowlog_retention" {
  type        = number
  description = "(optional) describe your variable"
}

variable "flowlog_traffic_type" {
  type        = string
  description = "Type of flowlog traffic to capture.  Valid values - ACCEPT, REJECT, ALL."
}

variable "endpoint_subnet_configs" {
  type        = list(any)
  description = "Public subnets configurations"
}

variable "tgw_subnet_configs" {
  type        = list(any)
  description = "Database subnets configurations"
}
variable "endpoint_tgw_configs" {
    type   = list(any)
    description ="endpoint_tgw configuration"
}