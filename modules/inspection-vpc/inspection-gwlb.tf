#Create subnets for inspection gwlb subnets
resource "aws_subnet" "inspection_gwlb_subnet" {
  for_each          = { for inspection_gwlb_subnet in var.inspection_gwlb_subnet_configs : inspection_gwlb_subnet.az => inspection_gwlb_subnet }
  vpc_id            = aws_vpc.inspection-vpc.id
  cidr_block        = each.value.cidr
  availability_zone = inspection_gwlb.aws_availability_zones.available.names[each.value.az]
  tags = merge(var.tags,
    {
      "Name" = "${var.tags["ClientName"]}-${var.type}-${each.value.name}"
      "Tier" = "data"
    }
  )
}
# Create route tables for each subnet
resource "aws_route_table" "inspection_gwlb_route_table" {
  for_each = { for inspection_gwlb_subnet in var.inspection_gwlb_subnet_configs : inspection_gwlb_subnet.az => inspection_gwlb_subnet }
  vpc_id   = aws_vpc.inspection-vpc.id
  tags     = merge(var.tags, { "Name" : "${var.tags["ClientName"]}-${var.type}-tgw-subnet-RT" })
}

# Route Association of inspection_gwlb subnet with inspection_gwlb route table
resource "aws_route_table_association" "inspection_gwlb_subnet_route_table_association" {
  for_each       = { for inspection_gwlb_subnet in var.inspection_gwlb_subnet_configs : inspection_gwlb_subnet.az => inspection_gwlb_subnet }
  subnet_id      = aws_subnet.inspection_gwlb_subnet[each.key].id
  route_table_id = aws_route_table.inspection_gwlb_route_table[each.key].id
}