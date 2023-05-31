# # Create Transit Gateway
# resource "aws_ec2_transit_gateway" "transit_gateway" {
#   description                     = var.transit_gateway_description
#   default_route_table_propagation = false
#   default_route_table_association = false
#   auto_accept_shared_attachments  = "disable"
# }

# # Create Transit Gateway Attachments
# resource "aws_ec2_transit_gateway_vpc_attachment" "attachments" {
#   for_each = var.vpc_attachments

#   transit_gateway_id = aws_ec2_transit_gateway.transit_gateway.id
#   vpc_id             = each.value.vpc_id
#   subnet_ids         = each.value.subnet_ids
# }

# # Share Transit Gateway across multiple accounts using RAM
# resource "aws_ram_resource_share" "transit_gateway_share" {
#   name                     = var.transit_gateway_share_name
#   allow_external_principals = true

#   principals {
#     type        = "AWS_ACCOUNT"
#     identifiers = var.shared_account_ids
#   }

#   resource_arns = [
#     aws_ec2_transit_gateway.transit_gateway.arn
#   ]
# }

