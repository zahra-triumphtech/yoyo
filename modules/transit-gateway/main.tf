# Create the transit gateway
resource "aws_ec2_transit_gateway" "transit_gateway" {
  description                     = "TGW-Internet"
  auto_accept_shared_attachments  = "disable"
  default_route_table_association = "disable"
  default_route_table_propagation = "disable"
    tags = {
    Name = "trans-gateway"
  }
}

# Create transit gateway attachments

resource "aws_ec2_transit_gateway_vpc_attachment" "egress_attachment" {
  transit_gateway_id        = aws_ec2_transit_gateway.transit_gateway.id
  vpc_id                    = var.egress_vpc_attachment
  subnet_ids                = var.egress_subnet_attachment
  tags = {
    Name = "Egress-Attachment"
  }
}
resource "aws_ec2_transit_gateway_vpc_attachment" "ingress_attachment" {
  transit_gateway_id        = aws_ec2_transit_gateway.transit_gateway.id
  vpc_id                    = var.ingress_vpc_attachment
  subnet_ids                = var.ingress_subnet_attachment
  tags = {
    Name = "Ingress-Attachment"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "endpoint_attachment" {
  transit_gateway_id        = aws_ec2_transit_gateway.transit_gateway.id
  vpc_id                    = var.endpoint_vpc_attachment
  subnet_ids                = var.endpoint_subnet_attachment
  tags = {
    Name = "Endpoint-Attachment"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "inspection_attachment" {
  transit_gateway_id        = aws_ec2_transit_gateway.transit_gateway.id
  vpc_id                    = var.inspection_vpc_attachment
  subnet_ids                = var.inspection_subnet_attachment
  tags = {
    Name = "Inspection-Attachment"
  }
}

###################################################################################################
# # Create Transit Gateway Route Tables
resource "aws_ec2_transit_gateway_route_table" "egress_route_table" {
  transit_gateway_id = aws_ec2_transit_gateway.transit_gateway.id
  tags = {
    Name = "Egress-RouteTable"
  }
}
resource "aws_ec2_transit_gateway_route_table" "ingress_route_table" {
  transit_gateway_id = aws_ec2_transit_gateway.transit_gateway.id
  tags = {
    Name = "Ingress-RouteTable"
  }
}
resource "aws_ec2_transit_gateway_route_table" "endpoint_route_table" {
  transit_gateway_id = aws_ec2_transit_gateway.transit_gateway.id
  tags = {
    Name = "Endpoint-RouteTable"
  }
}
resource "aws_ec2_transit_gateway_route_table" "inspection_route_table" {
  transit_gateway_id = aws_ec2_transit_gateway.transit_gateway.id
  tags = {
    Name = "Inspection-RouteTable"
  }
}

# Associate Transit Gateway Route Tables
resource "aws_ec2_transit_gateway_route_table_association" "egress_association" {
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.egress_route_table.id
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.egress_attachment.id
}
resource "aws_ec2_transit_gateway_route_table_association" "ingress_association" {
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.ingress_route_table.id
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.ingress_attachment.id
}
resource "aws_ec2_transit_gateway_route_table_association" "endpoint_association" {
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.endpoint_route_table.id
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.endpoint_attachment.id
}
resource "aws_ec2_transit_gateway_route_table_association" "inspection_association" {
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.inspection_route_table.id
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.inspection_attachment.id
}

# Create Transit Gateway Routes
resource "aws_ec2_transit_gateway_route" "egress_route" {
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.egress_route_table.id
  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.egress_attachment.id
}

# resource "aws_ec2_transit_gateway_route" "blackhole_route1" {
#   transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.app_route_table.id
#   destination_cidr_block         = "192.168.0.0/16"
#   blackhole                      = true
# }

# resource "aws_ec2_transit_gateway_route" "blackhole_route2" {
#   transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.app_route_table.id
#   destination_cidr_block         = "172.16.0.0/12"
#   blackhole                      = true
# }

# resource "aws_ec2_transit_gateway_route" "blackhole_route3" {
#   transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.app_route_table.id
#   destination_cidr_block         = "10.0.0.0/8"
#   blackhole                      = true
# }

# resource "aws_ec2_transit_gateway_route" "app1_route" {
#   transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.egress_route_table.id
#   destination_cidr_block         = "10.0.0.0/16"
#   transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.inspection_attachment.id
# }

# resource "aws_ec2_transit_gateway_route" "app2_route" {
#   transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.egress_route_table.id
#   destination_cidr_block         = "10.1.0.0/16"
#   transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.endpoint_attachment.id
# }

# Update default route tables in VPCs
# resource "aws_route_table_association" "update_route_table_vpc1" {
#   subnet_id      = aws_subnet.vpc1_subnet1.id
#   route_table_id = aws_vpc.vpc1.default_route_table_id
#   transit_gateway_id = aws_ec2_transit_gateway.transit_gateway.id
# }

# resource "aws_route_table_association" "update_route_table_vpc2" {
#   subnet_id      = aws_subnet.vpc2_subnet1.id
#   route_table_id = aws_vpc.egress_vpc.default_route_table_id
#   transit_gateway_id = aws_ec2_transit_gateway.transit_gateway.id
# }

# # Update Default Route Tables
# resource "aws_default_route_table_association" "app1_default_association" {
#   default_route_table_id = module.app1_vpc.default_route_table_id
#   transit_gateway_id     = aws_ec2_transit_gateway.transit_gateway.id
# }

# resource "aws_default_route_table_association" "app2_default_association" {
#   default_route_table_id = module.app2_vpc.default_route_table_id
#   transit_gateway_id     = aws_ec2_transit_gateway.transit_gateway.id
# }

# resource "aws_default_route_table_association" "egress_default_association" {
#   default_route_table_id = module.egress_vpc.default_route_table_id
#   transit_gateway_id     = aws_ec2_transit_gateway.transit_gateway.id
# }