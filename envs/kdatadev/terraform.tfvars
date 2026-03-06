prefix      = "kefe"
project     = "kcld"
environment = "sx1"

vpc_cidr = "10.201.0.0/20"

azs = ["us-east-1a", "us-east-1b", "us-east-1c"]

transit_gateway_id = ""

onprem_routes = []

enable_s3_endpoint = true

tags = {
  Account = "339713002785"
  Purpose = "VPC module simulation - simulates EFE Data DEV"
}
