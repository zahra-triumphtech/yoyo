#Create inspection_public subnets
resource "aws_subnet" "inspection_public_subnet" {
  for_each                           = { for inspection_public_subnet in var.inspection_public_subnet_configs : inspection_public_subnet.az => inspection_public_subnet }
  vpc_id                             = aws_vpc.inspection-vpc.id
  cidr_block                         = each.value.cidr
  availability_zone                  = data.aws_availability_zones.available.names[each.value.az]
  map_inspection_public_ip_on_launch = true
  tags = merge(var.tags,
    {
      "Name" = "${var.tags["ClientName"]}-${var.tags["Environment"]}-${each.value.name}"
      "Tier" = "public"
    }

  )
}

# Create inspection_public route table
resource "aws_route_table" "inspection_public_route_table" {
  vpc_id = aws_vpc.inspection-vpc.id
  tags   = merge(var.tags, { "Name" : "${var.tags["ClientName"]}-${var.tags["Environment"]}-inspection_public-Subnet-RT" })
}

# Define Internet-GW
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.inspection-vpc.id
  tags = {
    Name = "iGW"
  }
}

# Create route in inspection_public route table
resource "aws_route" "inspection_public_subnet_route" {
  route_table_id         = aws_route_table.inspection_public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gateway.id
}

# Route Association of inspection_public subnets with inspection_public route table
resource "aws_route_table_association" "inspection_public_subnet_route_table_association" {
  for_each       = { for inspection_public_subnet in var.inspection_public_subnet_configs : inspection_public_subnet.az => inspection_public_subnet }
  subnet_id      = aws_subnet.inspection_public_subnet[each.key].id
  route_table_id = aws_route_table.inspection_public_route_table.id
}
# #create IGW Route
# resource "aws_route" "igw" {
#   for_each               = { for inspection_public_subnet in var.inspection_public_subnet_configs : inspection_public_subnet.az => inspection_public_subnet }
#   route_table_id         = aws_route_table.inspection_public.id
#   destination_cidr_block = "0.0.0.0/0"
#   gateway_id             = aws_internet_gateway.internet_gateway.id
# }
#create Elastic IP
resource "aws_eip" "eip_nat" {
  for_each = { for inspection_public_subnet in var.inspection_public_subnet_configs : inspection_public_subnet.az => inspection_public_subnet }
  #  vpc      = true
}
#create NAT gateway
resource "aws_nat_gateway" "nat_gw" {
  for_each      = { for inspection_public_subnet in var.inspection_public_subnet_configs : inspection_public_subnet.az => inspection_public_subnet }
  allocation_id = aws_eip.eip_nat[each.key].id
  subnet_id     = aws_subnet.inspection_public_subnet[each.key].id
}