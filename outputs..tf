#
#vpc id
#
output "vpc_id" {
  value = aws_vpc.Endpoint_vpc.id
}

# #
# # endpoint_tgw
# #

output "endpoint_tgw__ids" {
  value       = [for k, v in aws_subnet.endpoint_tgw : v.id]
  description = "tGW subnet IDs"
}
# #
# # endpoint subnet
# #

output "endpoint_subnet_ids" {
  value       = [for k, v in aws_subnet.endpoint_subnet : v.id]
  description = "Endpoint subnet IDs"
}
