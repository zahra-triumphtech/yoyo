output "vpc_id" {
  value = aws_vpc.inspection_vpc.id
}

# # Private subnets

# output "private_subnet_ids" {
#   value       = [for k, v in aws_subnet.private_subnet : v.id]
#   description = "Private subnet IDs"
# }

# # Data subnets

output "tgw_subnet_ids" {
  value       = [for k, v in aws_subnet.inspection_tgw_subnet : v.id]
  description = "Data subnet IDs"
}

# # Public Subnets

# output "public_subnet_ids" {
#   value       = [for k, v in aws_subnet.public_subnet : v.id]
#   description = "Public subnet IDs"
# }
