# output "vpc_id" {
#   value = aws_vpc.vpc.id
# }

# # Private subnets

# output "private_subnet_ids" {
#   value       = [for k, v in aws_subnet.private_subnet : v.id]
#   description = "Private subnet IDs"
# }

# # Data subnets

# output "tgw_subnet_ids" {
#   value       = [for k, v in aws_subnet.data_subnet : v.id]
#   description = "Data subnet IDs"
# }

