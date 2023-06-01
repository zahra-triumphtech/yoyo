# Create Transit Gateway
resource "aws_ec2_transit_gateway" "transit_gateway" {
  description                     = var.transit_gateway_description
  default_route_table_propagation = false
  default_route_table_association = false
  auto_accept_shared_attachments  = "disable"
}

# Create Transit Gateway Attachments
resource "aws_ec2_transit_gateway_vpc_attachment" "attachments" {
  for_each = var.vpc_attachments

  transit_gateway_id = aws_ec2_transit_gateway.transit_gateway.id
  vpc_id             = each.value.vpc_id
  subnet_ids         = each.value.subnet_ids
}

# Share Transit Gateway across multiple accounts using RAM
resource "aws_ram_resource_share" "transit_gateway_share" {
  name                     = var.transit_gateway_share_name
  allow_external_principals = true

  principals {
    type        = "AWS_ACCOUNT"
    identifiers = var.shared_account_ids
  }

  resource_arns = [
    aws_ec2_transit_gateway.transit_gateway.arn
  ]
}
#####
#####
######
######
# main.tf

# Create the transit gateway
resource "aws_ec2_transit_gateway" "transit_gateway" {
  description                     = "TGW-Internet"
  auto_accept_shared_attachments  = "disable"
  default_route_table_association = "disable"
  default_route_table_propagation = "disable"
}

# Create transit gateway attachments
resource "aws_ec2_transit_gateway_vpc_attachment" "egress_attachment" {
  transit_gateway_id        = aws_ec2_transit_gateway.transit_gateway.id
  vpc_id                    = module.egress_vpc.vpc_id
  subnet_ids                = module.egress_vpc.subnet_ids
  tags = {
    Name = "Egress-Attachment"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "app1_attachment" {
  transit_gateway_id        = aws_ec2_transit_gateway.transit_gateway.id
  vpc_id                    = module.app1_vpc.vpc_id
  subnet_ids                = module.app1_vpc.subnet_ids
  tags = {
    Name = "App1-Attachment"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "app2_attachment" {
  transit_gateway_id        = aws_ec2_transit_gateway.transit_gateway.id
  vpc_id                    = module.app2_vpc.vpc_id
  subnet_ids                = module.app2_vpc.subnet_ids
  tags = {
    Name = "App2-Attachment"
  }
}

# #######
# #
# #####
# # Create Transit Gateway
# resource "aws_ec2_transit_gateway" "transit_gateway" {
#   description = "TGW-Internet"
# }

# # Create Transit Gateway Attachments
# resource "aws_ec2_transit_gateway_vpc_attachment" "egress_attachment" {
#   transit_gateway_id         = aws_ec2_transit_gateway.transit_gateway.id
#   vpc_id                     = module.egress_vpc.vpc_id
#   subnet_ids                 = module.egress_vpc.subnet_ids
# }

# resource "aws_ec2_transit_gateway_vpc_attachment" "inspection_attachment" {
#   transit_gateway_id         = aws_ec2_transit_gateway.transit_gateway.id
#   vpc_id                     = module.inspection_vpc.vpc_id
#   subnet_ids                 = module.inspection_vpc.subnet_ids
# }

# resource "aws_ec2_transit_gateway_vpc_attachment" "endpoint_attachment" {
#   transit_gateway_id         = aws_ec2_transit_gateway.transit_gateway.id
#   vpc_id                     = module.endpoint_vpc.vpc_id
#   subnet_ids                 = module.endpoint_vpc.subnet_ids
# }

# resource "aws_ec2_transit_gateway_vpc_attachment" "ingress_attachment" {
#   transit_gateway_id         = aws_ec2_transit_gateway.transit_gateway.id
#   vpc_id                     = module.ingress_vpc.vpc_id
#   subnet_ids                 = module.ingress_vpc.subnet_ids
# }

# # Create Transit Gateway Route Tables
# resource "aws_ec2_transit_gateway_route_table" "egress_route_table" {
#   transit_gateway_id = aws_ec2_transit_gateway.transit_gateway.id
# }

# resource "aws_ec2_transit_gateway_route_table" "app_route_table" {
#   transit_gateway_id = aws_ec2_transit_gateway.transit_gateway.id
# }

# # Associate Transit Gateway Route Tables
# resource "aws_ec2_transit_gateway_route_table_association" "egress_association" {
#   transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.egress_route_table.id
#   transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.egress_attachment.id
# }

# resource "aws_ec2_transit_gateway_route_table_association" "app_association" {
#   transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.app_route_table.id
#   transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.inspection_attachment.id
#   transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.endpoint_attachment.id
# }

# # Create Transit Gateway Routes
# resource "aws_ec2_transit_gateway_route" "egress_route" {
#   transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.app_route_table.id
#   destination_cidr_block         = "0.0.0.0/0"
#   transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.egress_attachment.id
# }

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
