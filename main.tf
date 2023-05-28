data "aws_region" "current" {}

resource "aws_vpc" "Endpoint_vpc" {
  cidr_block           = var.vpc_configs["vpc_cidr"]
  enable_dns_support   = true
  enable_dns_hostnames = true
#   tags                 = merge(var.tags, { "Name" = var.settings["main"]["name"] })
}

resource "aws_flow_log" "flowlogs" {
  log_destination = aws_cloudwatch_log_group.flowlogs.arn
  iam_role_arn    = aws_iam_role.flowlogs.arn
  vpc_id          = aws_vpc.Endpoint_vpc.id
  traffic_type    = var.flowlog_traffic_type
}
resource "aws_cloudwatch_log_group" "flowlogs" {
  name              = "/aws/flowlogs"
  retention_in_days = var.flowlog_retention
#   tags              = merge(var.tags, { "Name" = var.settings["main"]["name"] })
}
resource "aws_vpc_endpoint" "endpoint" {
  vpc_id              = aws_vpc.Endpoint_vpc.id
  service_name        = "com.amazonaws.${var.aws_region}.s3"
  vpc_endpoint_type   = "Gateway"
  route_table_ids     = [aws_route_table.endpoint_subnet_route_table.id]
}
data "aws_availability_zones" "available" {
  state = "available"
}
