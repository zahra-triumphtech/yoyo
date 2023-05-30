#Create private inspection_mgmt subnets
resource "aws_subnet" "inspection_mgmt_subnet" {
  for_each          = { for inspection_mgmt_subnet in var.tgw_subnet_configs : inspection_mgmt_subnet.az => inspection_mgmt_subnet }
  vpc_id            = aws_vpc.inspection-vpc.id
  cidr_block        = each.value.cidr
  availability_zone = data.aws_availability_zones.available.names[each.value.az]
  tags = merge(var.tags,
    {
      "Name" = "${var.tags["ClientName"]}-${var.tags["Environment"]}-${each.value.name}"
      "Tier" = "data"
    }
  )
}
# Create data route table
resource "aws_route_table" "inspection_mgmt_route_table" {
  vpc_id = aws_vpc.inspection-vpc.id
  tags   = merge(var.tags, { "Name" : "${var.tags["ClientName"]}-${var.tags["Environment"]}-inspection_mgmt-Subnet-RT" })
}

# Route Association of data subnet with inspection_mgmt route table
resource "aws_route_table_association" "inspection_mgmt_subnet_route_table_association" {
  for_each       = { for inspection_mgmt_subnet in var.tgw_subnet_configs : inspection_mgmt_subnet.az => inspection_mgmt_subnet }
  subnet_id      = aws_subnet.inspection_mgmt_subnet[each.key].id
  route_table_id = aws_route_table.inspection_mgmt_route_table.id
}
