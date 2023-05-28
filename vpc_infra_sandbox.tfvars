# General
region      = "us-east-1"
tags        = {
  "ClientName"  = "finofo"
  "Environment" = "sandbox"
  "ManagedBy"   = "terraform"
}

# VPC
vpc_configs = {
  vpc_name = "Endpoint_vpc"
  vpc_cidr = "10.104.8.0/21"
}
flowlog_retention    = 7
flowlog_traffic_type = "ALL"
endpoint_subnet_configs = [
  {
    name = "Endpoint_subnet 1"
    cidr = "10.104.10.0/23"
    az   = 0
  },
  {
    name = "Endpoint_subnet 2"
    cidr = "10.104.4.16/28"
    az   = 1
  },
  {
    name = "Endpoint-Subnet3"
    cidr = "10.104.12.0/23"
    az   = 2
  }
]

tgw_subnet_configs = [
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

availability_zones = ["us-east-1a","us-east-1b","us-east-1c"]
#
#tgw_endpoint_configs
#

endpoint_tgw_configs = [
  
  { az = "us-east-1a"
   cidr = "110.104.14.0/28" },

  
{ az = "us-east-1b"
 cidr = "10.104.14.16/28" },

{ az = "us-east-1c"
cidr = "10.104.14.32/28" }
]
