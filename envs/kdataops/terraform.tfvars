prefix      = "efe"
project     = "data"
environment = "ops"

vpc_cidr = "10.93.0.0/20"

azs = ["us-east-1a", "us-east-1b", "us-east-1c"]

transit_gateway_id = ""

onprem_routes = []

enable_s3_endpoint = true

tags = {
  Account = "882705246437"
  Purpose = "VPC Data EFE"
}
