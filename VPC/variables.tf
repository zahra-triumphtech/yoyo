variable "region" {
  type        = string
  description = "Region to deploy in"
  default     = "us-east-1"
}

variable "tags" {
  type        = map(string)
  description = "Tags to associate to the resources"
}

# Egress VPC

variable "egress_vpc_configs" {
  type        = map(any)
  description = "VPC configurations"
}

variable "egress_flowlog_retention" {
  type        = number
  description = "(optional) describe your variable"
}

variable "egress_flowlog_traffic_type" {
  type        = string
  description = "Type of flowlog traffic to capture.  Valid values - ACCEPT, REJECT, ALL."
}

variable "egress_public_subnet_configs" {
  type        = list(any)
  description = "Public subnets configurations"
}

variable "egress_tgw_subnet_configs" {
  type        = list(any)
  description = "Database subnets configurations"
}

# Endpoint VPC

variable "endpoint_vpc_configs" {
  type        = map(any)
  description = "VPC configurations"
}

variable "endpoint_flowlog_retention" {
  type        = number
  description = "(optional) describe your variable"
}

variable "endpoint_flowlog_traffic_type" {
  type        = string
  description = "Type of flowlog traffic to capture.  Valid values - ACCEPT, REJECT, ALL."
}

variable "endpoint_subnet_configs" {
  type        = list(any)
  description = "Public subnets configurations"
}

variable "endpoint_tgw_subnet_configs" {
  type        = list(any)
  description = "Database subnets configurations"
}

#Ingress VPC

variable "ingress_vpc_configs" {
  type        = map(any)
  description = "VPC configurations"
}

variable "ingress_flowlog_retention" {
  type        = number
  description = "(optional) describe your variable"
}

variable "ingress_flowlog_traffic_type" {
  type        = string
  description = "Type of flowlog traffic to capture.  Valid values - ACCEPT, REJECT, ALL."
}

variable "ingress_gwlbe_subnet_configs" {
  type        = list(any)
  description = "Public subnets configurations"
}

variable "ingress_public_subnet_configs" {
  type        = list(any)
  description = "Database subnets configurations"
}
variable "ingress_tgw_subnet_configs" {
  type        = list(any)
  description = "Database subnets configurations"
}

# Inspection VPC

variable "inspection_vpc_configs" {
  type        = map(any)
  description = "VPC configurations"
}

variable "inspection_flowlog_retention" {
  type        = number
  description = "(optional) describe your variable"
}

variable "inspection_flowlog_traffic_type" {
  type        = string
  description = "Type of flowlog traffic to capture.  Valid values - ACCEPT, REJECT, ALL."
}

variable "inspection_subnet_configs" {
  type        = list(any)
  description = "Public subnets configurations"
}

variable "inspection_tgw_subnet_configs" {
  type        = list(any)
  description = "Database subnets configurations"
}

#transit gateway

variable "transit_gateway_description" {
  description = "Description for the Transit Gateway"
  type        = string
}

variable "transit_gateway_share_name" {
  description = "Name for the Transit Gateway RAM resource share"
  type        = string
}

variable "vpc_attachments" {
  description = "Map of VPC attachments for the Transit Gateway"
  type        = map(object({
    vpc_id     = string
    subnet_ids = list(string)
  }))
}

variable "shared_account_ids" {
  description = "List of AWS account IDs to share Transit Gateway with"
  type        = list(string)
}
