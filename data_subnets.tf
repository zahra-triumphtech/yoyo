resource "aws_subnet" "endpoint_tgw" {
  for_each          = { for endpoint-tgw in var.endpoint_tgw_configs : endpoint-tgw.az => endpoint-tgw }
  vpc_id            = aws_vpc.Endpoint_vpc.id
  cidr_block        = each.value.cidr
  availability_zone = endpoint_tgw.aws_availability_zones.available.names[each.value.az]


}

#
# Route Resources
#

# Create endpoint_tgw route table
resource "aws_route_table" "endpoint_tgw_route_table" {
  vpc_id = aws_vpc.Endpoint_vpc.id
 
}

# Route Association of endpoint_tgw subnet with endpoint_tgw route table
resource "aws_route_table_association" "endpoint_tgw_route_table_association" {
  for_each       = { for endpoint_tgw in var.endpoint_tgw_configs : endpoint_tgw.az => endpoint_tgw }
  subnet_id      = aws_subnet.endpoint_tgw[each.key].id
  route_table_id = aws_route_table.endpoint_tgw_route_table.id
}
resource "aws_route_table" "endpoint_tgw" {
  for_each = toset(var.availability_zones)
  vpc_id   = aws_vpc.Endpoint_vpc.id


}

resource "aws_route_table_association" "endpoint_tgw" {
  for_each       = toset(var.availability_zones)
  subnet_id      = aws_subnet.endpoint_tgw[each.key].id
  route_table_id = aws_route_table.endpoint_tgw[each.key].id
}
