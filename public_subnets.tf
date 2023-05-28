#  Subnet with default route to a Internet gateway.
 resource "aws_subnet" "endpoint_subnet" {
   for_each                = { for endpoint_subnet in var.endpoint_subnet_configs : endpoint_subnet.az => endpoint_subnet }
   vpc_id                  = aws_vpc.Endpoint_vpc.id
   cidr_block              = each.value.cidr
   availability_zone       = data.aws_availability_zones.available.names[each.value.az]
 }

# Create public route table
resource "aws_route_table" "endpoint_subnet_route_table" {
  vpc_id = aws_vpc.Endpoint_vpc.id
}

# Create route in public route table
resource "aws_route" "endpoint_subnet_route" {
  route_table_id         = aws_route_table.endpoint_subnet_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  vpc_endpoint_id        = aws_vpc_endpoint.endpoint.id
}

# Route Association of public subnets with public route table
resource "aws_route_table_association" "endpoint_subnet_route_table_association" {
  for_each       = { for endpoint_subnet in var.endpoint_subnet_configs : endpoint_subnet.az => endpoint_subnet }
  subnet_id      = aws_subnet.endpoint_subnet[each.key].id
  route_table_id = aws_route_table.endpoint_subnet_route_table.id
}

data "aws_availability_zones" "available" {}
