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

#Ingress VPC

ingress_vpc_configs = {
  vpc_name = "Ingress vpc"
  vpc_cidr = "10.104.2.0/23"
}
ingress_flowlog_retention    = 7
ingress_flowlog_traffic_type = "ALL"
ingress-gwlbe_configs = [
  {
    name = "Ingress-gwlbe 1"
    cidr = "10.104.2.0/28"
    az   = 0
  },
  {
    name = "Ingress-gwlbe 2"
    cidr = "10.104.2.16/28"
    az   = 1
  },
  {
    name = "Ingress-gwlbe 3"
    cidr = "10.104.2.32/28"
    az   = 2
  }
]

ingress-public_configs = [
  {
    name = "Ingress-public 1"
    cidr = "10.104.2.128/25"
    az   = 0
  },
  {
    name = "Ingress-public 2"
    cidr = "10.104.3.0/25"
    az   = 1
  },
  {
    name = "Ingress-public 3"
    cidr = "10.104.3.128/25"
    az   = 2
  }
]

ingress-tgw_configs = [
  {
    name = "Ingress-tgw 1"
    cidr = "10.104.2.48/28"
    az   = 0
  },
  {
    name = "Ingress-tgw 2"
    cidr = "10.104.2.64/28"
    az   = 1
  },
  {
    name = "Ingress-tgw3"
    cidr = "10.104.2.80/28"
    az   = 2
  }
]

# Inspection VPC
inspection_vpc_configs = {
  vpc_name = "inspection-vpc"
  vpc_cidr = "10.104.0.0/23"
}
inspection_flowlog_retention    = 7
inspection_flowlog_traffic_type = "ALL"
inspection_subnet_configs = [

inspection_mgmt_subnet_configs = [
  {
    name = "inspection-mgmt1"
    cidr = "10.104.0.0/28"
    az   = 0
  },
  {
    name = "inspection-mgmt2"
    cidr = "10.104.0.16/28"
    az   = 1
  },
  {
    name = "inspection-mgmt3"
    cidr = "10.104.0.32/28"
    az   = 2
  }
]
inspection_public_subnet_configs = [
  {
    name = "inspection-public1"
    cidr = "10.104.0.48/28"
    az   = 0
  },
  {
    name = "inspection-public2"
    cidr = "10.104.0.64/28"
    az   = 1
  },
  {
    name = "inspection-public3"
    cidr = "10.104.0.80/28"
    az   = 2
  }
]

inspection_fw_subnet_configs = [
  {
    name = "inspection-fw1"
    cidr = "10.104.0.96/28"
    az   = 0
  },
  {
    name = "inspection-fw2"
    cidr = "10.104.0.112/28"
    az   = 1
  },
  {
    name = "inspection-fw3"
    cidr = "10.104.0.128/28"
    az   = 2
  }
]


inspection_gwlb_subnet_configs = [
  {
    name = "inspection-gwlb1"
    cidr = "10.104.0.160/27"
    az   = 0
  },
  {
    name = "inspection-gwlb2"
    cidr = "10.104.0.192/27"
    az   = 1
  },
  {
    name = "inspection-gwlb3"
    cidr = "10.104.0.224/27"
    az   = 2
  }
]

inspection_gwlbe_subnet_configs = [
  {
    name = "inspection-gwlbe1"
    cidr = "10.104.1.0/28"
    az   = 0
  },
  {
    name = "inspection-gwlbe2"
    cidr = "10.104.1.16/28"
    az   = 1
  },
  {
    name = "inspection-gwlbe3"
    cidr = "10.104.1.32/28"
    az   = 2
  }
]

inspection_tgw_subnet_configs = [
  {
    name = "inspection-tgw1"
    cidr = "10.104.1.48/28"
    az   = 0
  },
  {
    name = "inspection-tgw2"
    cidr = "10.104.1.64/28"
    az   = 1
  },
  {
    name = "inspection-tgw3"
    cidr = "10.104.1.80/28"
    az   = 2
  }
]
]