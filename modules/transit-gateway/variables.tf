variable "egress_vpc_attachment" {
  description = "egress vpc tgw attachment"
  type        = string  
}
variable "egress_subnet_attachment" {
  description = "egress subnet tgw attachment"
  type        = list(any) 
}
variable "ingress_vpc_attachment" {
  description = "ingress vpc tgw attachment"
  type        = string  
}
variable "ingress_subnet_attachment" {
  description = "ingress subnet tgw attachment"
  type        = list(any) 
}

variable "endpoint_vpc_attachment" {
  description = "endpoint vpc tgw attachment"
  type        = string  
}
variable "endpoint_subnet_attachment" {
  description = "endpoint subnet tgw attachment"
  type        = list(any) 
}

variable "inspection_vpc_attachment" {
  description = "inspection vpc tgw attachment"
  type        = string  
}
variable "inspection_subnet_attachment" {
  description = "inspection subnet tgw attachment"
  type        = list(any) 
}


# variable "transit_gateway_description" {
#   description = "Description for the Transit Gateway"
#   type        = string
# }

# variable "transit_gateway_share_name" {
#   description = "Name for the Transit Gateway RAM resource share"
#   type        = string
# }

# variable "vpc_attachments" {
#   description = "Map of VPC attachments for the Transit Gateway"
#   type        = map(object({
#     vpc_id     = string
#     subnet_ids = list(string)
#   }))
# }

# variable "shared_account_ids" {
#   description = "List of AWS account IDs to share Transit Gateway with"
#   type        = list(string)
# }
 ####
 ####
#  #####
#  variable "aws_region" {
#   description = "AWS region"
#   default     = "us-west-2"
# }

# variable "egress_vpc_attachment_id" {
#   description = "ID of the Transit Gateway attachment for the egress VPC"
# }

# variable "inspection_vpc_attachment_id" {
#   description = "ID of the Transit Gateway attachment for the inspection VPC"
# }

# variable "endpoint_vpc_attachment_id" {
#   description = "ID of the Transit Gateway attachment for the endpoint VPC"
# }

# variable "ingress_vpc_attachment_id" {
#   description = "ID of the Transit Gateway attachment for the ingress VPC"
# }

# variable "app_route_table_id" {
#   description = "ID of the Transit Gateway route table for the app traffic"
# }

# variable "egress_route_table_id" {
#   description = "ID of the Transit Gateway route table for the egress traffic"
# }

# variable "app1_default_route_table_id" {
#   description = "ID of the default route table in the app1 VPC"
# }

# variable "app2_default_route_table_id" {
#   description = "ID of the default route table in the app2 VPC"
# }

# variable "egress_default_route_table_id" {
#   description = "ID of the default route table in the egress VPC"
# }