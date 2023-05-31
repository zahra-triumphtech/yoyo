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
