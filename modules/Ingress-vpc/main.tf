# Declare the data source for AZs 
data "aws_availability_zones" "available" {
  state = "available"
}

# Create VPC resource
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_configs["vpc_cidr"]
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags                 = merge(var.tags, { "Name" = "${var.tags["ClientName"]}-${var.type}-${var.vpc_configs["vpc_name"]}" })
}

resource "aws_cloudwatch_log_group" "flowlogs" {
  name              = "/aws/flowlogs/${var.tags["ClientName"]}-${var.type}-${var.vpc_configs["vpc_name"]}"
  retention_in_days = var.flowlog_retention
  tags              = var.tags
}

resource "aws_flow_log" "flowlogs" {
  log_destination = aws_cloudwatch_log_group.flowlogs.arn
  iam_role_arn    = aws_iam_role.flowlogs.arn
  vpc_id          = aws_vpc.vpc.id
  traffic_type    = var.flowlog_traffic_type
}