#Create subnets for Inspection_tgw subnets
resource "aws_subnet" "inspection_tgw_subnet" {
  for_each          = { for inspection_tgw_subnet in var.inspection_tgw_subnet_configs : inspection_tgw_subnet.az => inspection_tgw_subnet }
  vpc_id            = aws_vpc.inspection-vpc.id
  cidr_block        = each.value.cidr
  availability_zone = inspection_tgw.aws_availability_zones.available.names[each.value.az]
  tags = merge(var.tags,
    {
      "Name" = "${var.tags["ClientName"]}-${var.type}-${each.value.name}"
      "Tier" = "data"
    }
  )
}
# Create route tables for each subnet
resource "aws_route_table" "inspection_tgw_route_table" {
  for_each = { for inspection_tgw_subnet in var.inspection_tgw_subnet_configs : inspection_tgw_subnet.az => inspection_tgw_subnet }
  vpc_id   = aws_vpc.inspection-vpc.id
  tags     = merge(var.tags, { "Name" : "${var.tags["ClientName"]}-${var.type}-tgw-subnet-RT" })
}

# Route Association of inspection_tgw subnet with inspection_tgw route table
resource "aws_route_table_association" "inspection_tgw_subnet_route_table_association" {
  for_each       = { for inspection_tgw_subnet in var.inspection_tgw_subnet_configs : inspection_tgw_subnet.az => inspection_tgw_subnet }
  subnet_id      = aws_subnet.inspection_tgw_subnet[each.key].id
  route_table_id = aws_route_table.inspection_tgw_route_table[each.key].id
}