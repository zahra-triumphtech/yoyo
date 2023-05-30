#Create public subnets
resource "aws_subnet" "ingress_public_subnet" {
  for_each                = { for ingress_public_subnet in var.ingress_public_subnet_configs : ingress_public_subnet.az => ingress_public_subnet }
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = each.value.cidr
  availability_zone       = data.aws_availability_zones.available.names[each.value.az]
  map_public_ip_on_launch = true
  tags = merge(var.tags,
    {
      "Name" = "${var.tags["ClientName"]}-${var.type}-${each.value.name}"
      "Tier" = "public"
    }

  )
}

# Create public route table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id
  tags   = merge(var.tags, { "Name" : "${var.tags["ClientName"]}-${var.type}-Public-Subnet-RT" })
}

# Define Internet-GW
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "iGW"
  }
}

# Create route in public route table
resource "aws_route" "ingress_public_subnet_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gateway.id
}

# Route Association of public subnets with public route table
resource "aws_route_table_association" "ingress_public_subnet_route_table_association" {
  for_each       = { for ingress_public_subnet in var.ingress_public_subnet_configs : ingress_public_subnet.az => ingress_public_subnet }
  subnet_id      = aws_subnet.ingress_public_subnet[each.key].id
  route_table_id = aws_route_table.public_route_table.id
}

#create Elastic IP
resource "aws_eip" "eip_nat" {
  for_each = { for ingress_public_subnet in var.ingress_public_subnet_configs : ingress_public_subnet.az => ingress_public_subnet }
  #  vpc      = true
}
#create NAT gateway
resource "aws_nat_gateway" "nat_gw" {
  for_each      = { for ingress_public_subnet in var.ingress_public_subnet_configs : ingress_public_subnet.az => ingress_public_subnet }
  allocation_id = aws_eip.eip_nat[each.key].id
  subnet_id     = aws_subnet.ingress_public_subnet[each.key].id
}