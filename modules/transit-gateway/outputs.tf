output "transit_gateway_id" {
  value = aws_ec2_transit_gateway.transit_gateway.id
}

# output "egress_attachment_id" {
#   value = aws_ec2_transit_gateway_vpc_attachment.egress_attachment.id
# }

# output "inspection_attachment_id" {
#   value = aws_ec2_transit_gateway_vpc_attachment.inspection_attachment.id
# }

# output "endpoint_attachment_id" {
#   value = aws_ec2_transit_gateway_vpc_attachment.endpoint_attachment.id
# }

# output "ingress_attachment_id" {
#   value = aws_ec2_transit_gateway_vpc_attachment.ingress_attachment.id
# }

# output "app_route_table_id" {
#   value = aws_ec2_transit_gateway_route_table.app_route_table.id
# }

# output "egress_route_table_id" {
#   value = aws_ec2_transit_gateway_route_table.egress_route_table.id
# }

# output "app1_default_association_id" {
#   value = aws_default_route_table_association.app1_default_association.id
# }

# output "app2_default_association_id" {
#   value = aws_default_route_table_association.app2_default_association.id
# }

# output "egress_default_association_id" {
#   value = aws_default_route_table_association.egress_default_association.id
# }