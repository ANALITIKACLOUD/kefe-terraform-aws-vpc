prefix      = "kefe"
project     = "data"
environment = "ops"

vpc_cidr = "10.93.0.0/20"

azs = ["us-east-1a", "us-east-1b", "us-east-1c"]

transit_gateway_id = "tgw-0d8bbe277bfa6c109"

private_subnet_offset = 7
tgw_subnet_offset     = 0

onprem_routes = [
  { cidr = "10.1.71.0/24", description = "VPN Derby Piso 2" },
  { cidr = "12.1.71.0/24", description = "VPN Derby secundario" },
  { cidr = "10.125.0.0/16", description = "Red corporativa EFE" },
  { cidr = "10.130.0.0/16", description = "Red corporativa EFE" },
]

enable_s3_endpoint = true

tags = {
  Account = "585853725481"
}
