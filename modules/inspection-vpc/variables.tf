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
variable "inspection_vpc_configs" {
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

variable "mgmt_subnet_configs" {
  type        = list(any)
  description = "mgmt subnets configurations"
}
variable "public_subnet_configs" {
  type        = list(any)
  description = "public subnets configurations"
}
variable "fw_subnet_configs" {
  type        = list(any)
  description = "fw subnets configurations"
}
variable "gwlb_subnet_configs" {
  type        = list(any)
  description = "gwlb subnets configurations"
}
variable "gwlbe_subnet_configs" {
  type        = list(any)
  description = "gwlbe subnets configurations"
}
variable "tgw_subnet_configs" {
  type        = list(any)
  description = "tgw subnets configurations"
}
