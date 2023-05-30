#Create subnets for TGW subnets
resource "aws_subnet" "data_subnet" {
  for_each          = { for data_subnet in var.ingress_tgw_subnet_configs : data_subnet.az => data_subnet }
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.value.cidr
  availability_zone = data.aws_availability_zones.available.names[each.value.az]
  tags = merge(var.tags,
    {
      "Name" = "${var.tags["ClientName"]}-${var.type}-${each.value.name}"
      "Tier" = "data"
    }
  )
}
# Create route tables for each subnet
resource "aws_route_table" "data_route_table" {
  for_each = { for data_subnet in var.ingress_tgw_subnet_configs : data_subnet.az => data_subnet }
  vpc_id   = aws_vpc.vpc.id
  tags     = merge(var.tags, { "Name" : "${var.tags["ClientName"]}-${var.type}-tgw-subnet-RT" })
}

# Route Association of data subnet with data route table
resource "aws_route_table_association" "data_subnet_route_table_association" {
  for_each       = { for data_subnet in var.ingress_tgw_subnet_configs : data_subnet.az => data_subnet }
  subnet_id      = aws_subnet.data_subnet[each.key].id
  route_table_id = aws_route_table.data_route_table[each.key].id
}