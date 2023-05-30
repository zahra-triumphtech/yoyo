#Create subnets for inspection gwlbe subnets
resource "aws_subnet" "inspection_gwlbe_subnet" {
  for_each          = { for inspection_gwlbe_subnet in var.inspection_gwlbe_subnet_configs : inspection_gwlbe_subnet.az => inspection_gwlbe_subnet }
  vpc_id            = aws_vpc.inspection_vpc.id
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
resource "aws_route_table" "inspection_gwlbe_route_table" {
  for_each = { for inspection_gwlbe_subnet in var.inspection_gwlbe_subnet_configs : inspection_gwlbe_subnet.az => inspection_gwlbe_subnet }
  vpc_id   = aws_vpc.inspection_vpc.id
  tags     = merge(var.tags, { "Name" : "${var.tags["ClientName"]}-${var.type}-tgw-subnet-RT" })
}

# Route Association of inspection_gwlbe subnet with inspection_gwlbe route table
resource "aws_route_table_association" "inspection_gwlbe_subnet_route_table_association" {
  for_each       = { for inspection_gwlbe_subnet in var.inspection_gwlbe_subnet_configs : inspection_gwlbe_subnet.az => inspection_gwlbe_subnet }
  subnet_id      = aws_subnet.inspection_gwlbe_subnet[each.key].id
  route_table_id = aws_route_table.inspection_gwlbe_route_table[each.key].id
}