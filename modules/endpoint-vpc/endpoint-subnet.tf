#Create subnets for TGW subnets
resource "aws_subnet" "endpoint_subnet" {
  for_each          = { for endpoint_subnet in var.endpoint_subnet_configs : endpoint_subnet.az => endpoint_subnet }
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.value.cidr
  availability_zone = data.aws_availability_zones.available.names[each.value.az]
  tags = merge(var.tags,
    {
      "Name" = "${var.tags["ClientName"]}-${each.value.name}"
      "Tier" = "Endpoint"
    }
  )
}
# Create endpoint route table
resource "aws_route_table" "endpoint_route_table" {
  vpc_id = aws_vpc.vpc.id
  tags   = merge(var.tags, { "Name" : "${var.tags["ClientName"]}-${var.type}-subnet-RT" })
}

# Route Association of endpoint subnet with endpoint route table
resource "aws_route_table_association" "endpoint_subnet_route_table_association" {
  for_each       = { for endpoint_subnet in var.tgw_subnet_configs : endpoint_subnet.az => endpoint_subnet }
  subnet_id      = aws_subnet.endpoint_subnet[each.key].id
  route_table_id = aws_route_table.endpoint_route_table.id
}

#S3 Endpoint
resource "aws_vpc_endpoint" "s3" {
  vpc_id       = aws_vpc.vpc.id
  service_name = "com.amazonaws.${var.region}.s3"
}

#
# VPC Endpoint - Subnet route associations
#

resource "aws_vpc_endpoint_route_table_association" "endpoint" {
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
  route_table_id  = aws_route_table.endpoint_route_table.id
}