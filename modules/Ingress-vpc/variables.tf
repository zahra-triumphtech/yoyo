variable "region" {
  type        = string
  description = "Region to deploy in"
  default     = "us-east-1"
}
variable "tags" {
  type        = map(any)
  description = "Tags to apply to all resources."
}
variable "type" {
  type        = string
  description = "type of VPC"
}
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

variable "gwlbe_configs" {
  type        = list(any)
  description = "Public subnets configurations"
}
variable "public_configs" {
  type        = list(any)
  description = "Database subnets configurations"
}
variable "tgw_configs" {
  type        = list(any)
  description = "Database subnets configurations"
}