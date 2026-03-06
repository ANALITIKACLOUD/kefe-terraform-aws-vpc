prefix      = "kefe"
project     = "data"
environment = "qa"

vpc_cidr = "10.92.0.0/20"

azs = ["us-east-1a", "us-east-1b", "us-east-1c"]

transit_gateway_id = ""

onprem_routes = []

enable_s3_endpoint = true

tags = {
  Account = "471112840515"
  Purpose = "VPC Data EFE"
}
