module "egress_vpc" {
  source                = "../modules/egress-vpc"
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
  ingress_subnet_configs = var.ingress_subnet_configs
  tgw_subnet_configs     = var.ingress_tgw_subnet_configs
  tags                   = var.tags
}
module "inspection_vpc" {
  source                        = "../modules/inspection-vpc"
  type                          = "inspection"
  vpc_configs                   = var.inspection_vpc_configs
  flowlog_retention             = var.inspection_flowlog_retention
  flowlog_traffic_type          = var.inspection_flowlog_traffic_type
  inspection_subnet_configs     = var.inspection_subnet_configs
  inspection_tgw_subnet_configs = var.inspection_tgw_subnet_configs
  tags                          = var.tags
}