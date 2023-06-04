module "egress_vpc" {
  source                = "../modules/egressvpc"
  type                  = "egress"
  vpc_configs           = var.egress_vpc_configs
  flowlog_retention     = var.egress_flowlog_retention
  flowlog_traffic_type  = var.egress_flowlog_traffic_type
  public_subnet_configs = var.egress_public_subnet_configs
  tgw_subnet_configs    = var.egress_tgw_subnet_configs
  tags                  = var.tags
}

module "endpoint_vpc" {
  source                  = "../modules/endpoint-vpc"
  type                    = "endpoint"
  vpc_configs             = var.endpoint_vpc_configs
  flowlog_retention       = var.endpoint_flowlog_retention
  flowlog_traffic_type    = var.endpoint_flowlog_traffic_type
  endpoint_subnet_configs = var.endpoint_subnet_configs
  tgw_subnet_configs      = var.endpoint_tgw_subnet_configs
  tags                    = var.tags
}
module "ingress_vpc" {
  source                 = "../modules/ingress-vpc"
  type                   = "ingress"
  vpc_configs            = var.ingress_vpc_configs
  flowlog_retention      = var.ingress_flowlog_retention
  flowlog_traffic_type   = var.ingress_flowlog_traffic_type
  public_subnet_configs  = var.ingress_public_subnet_configs
  tgw_subnet_configs     = var.ingress_tgw_subnet_configs
  gwlbe_subnet_configs   = var.ingress_gwlbe_subnet_configs
  tags                   = var.tags
}
module "inspection_vpc" {
  source                 = "../modules/inspection-vpc"
  type                   = "inspection"
  inspection_vpc_configs = var.inspection_vpc_configs
  flowlog_retention      = var.inspection_flowlog_retention
  flowlog_traffic_type   = var.inspection_flowlog_traffic_type
  mgmt_subnet_configs    = var.inspection_mgmt_subnet_configs
  public_subnet_configs  = var.inspection_public_subnet_configs
  fw_subnet_configs      = var.inspection_fw_subnet_configs
  gwlb_subnet_configs    = var.inspection_gwlb_subnet_configs
  gwlbe_subnet_configs   = var.inspection_gwlbe_subnet_configs
  tgw_subnet_configs     = var.inspection_tgw_subnet_configs
  tags                   = var.tags
}
module "transit_gateway" {
  source = "../modules/transit-gateway"
  vpc_ids = [module.egress_vpc.vpc_id, module.ingress_vpc.vpc_id, module.endpoint_vpc.vpc_id, module.inspection_vpc.vpc_id]
  subnet_ids = [module.egress_vpc.tgw_subnet_ids, module.ingress_vpc.tgw_subnet_ids, module.endpoint_vpc.tgw_subnet_ids, module.inspection_vpc.tgw_subnet_ids]
  
  egress_vpc_attachment = module.egress_vpc.vpc_id
  egress_subnet_attachment = module.egress_vpc.tgw_subnet_ids

  ingress_vpc_attachment = module.ingress_vpc.vpc_id
  ingress_subnet_attachment = module.ingress_vpc.tgw_subnet_ids
  
  endpoint_vpc_attachment = module.endpoint_vpc.vpc_id
  endpoint_subnet_attachment = module.endpoint_vpc.tgw_subnet_ids
  
  inspection_vpc_attachment = module.inspection_vpc.vpc_id
  inspection_subnet_attachment = module.inspection_vpc.tgw_subnet_ids

  # transit_gateway_description = var.transit_gateway_description
  # transit_gateway_share_name  = var.transit_gateway_share_name
  # vpc_attachments             = var.vpc_attachments
  # shared_account_ids          = var.shared_account_ids
}