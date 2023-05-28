# General
region      = "us-east-1"
tags        = {
  "ClientName"  = "network"
  "ManagedBy"   = "terraform"
}

# Egress VPC
egress_vpc_configs = {
  vpc_name = "vpc"
  vpc_cidr = "10.104.4.0/24"
}
egress_flowlog_retention    = 7
egress_flowlog_traffic_type = "ALL"
egress_public_subnet_configs = [
  {
    name = "public-Subnet1"
    cidr = "10.104.4.0/28"
    az   = 0
  },
  {
    name = "public-Subnet2"
    cidr = "10.104.4.16/28"
    az   = 1
  },
  {
    name = "public-Subnet3"
    cidr = "10.104.4.32/28"
    az   = 2
  }
]

egress_tgw_subnet_configs = [
  {
    name = "tgw-Subnet1"
    cidr = "10.104.4.96/28"
    az   = 0
  },
  {
    name = "tgw-Subnet2"
    cidr = "10.104.4.112/28"
    az   = 1
  },
  {
    name = "tgw-Subnet3"
    cidr = "10.104.4.128/28"
    az   = 2
  }
]
# Endpoint VPC
endpoint_vpc_configs = {
  vpc_name = "vpc"
  vpc_cidr = "10.104.8.0/21"
}
endpoint_flowlog_retention    = 7
endpoint_flowlog_traffic_type = "ALL"

endpoint_subnet_configs = [
  {
    name = "endpoint-Subnet1"
    cidr = "10.104.8.0/23"
    az   = 0
  },
  {
    name = "endpoint-Subnet2"
    cidr = "10.104.10.0/23"
    az   = 1
  },
  {
    name = "endpoint-Subnet3"
    cidr = "10.104.12.0/23"
    az   = 2
  }
]

endpoint_tgw_subnet_configs = [
  {
    name = "tgw-Subnet1"
    cidr = "10.104.14.0/28"
    az   = 0
  },
  {
    name = "tgw-Subnet2"
    cidr = "10.104.14.16/28"
    az   = 1
  },
  {
    name = "tgw-Subnet3"
    cidr = "10.104.14.32/28"
    az   = 2
  }
]