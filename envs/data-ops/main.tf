terraform {
  backend "s3" {}
}

provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "../../"

  prefix      = var.prefix
  project     = var.project
  environment = var.environment
  vpc_cidr    = var.vpc_cidr

  azs                    = var.azs
  transit_gateway_id     = var.transit_gateway_id
  private_subnet_newbits = var.private_subnet_newbits
  tgw_subnet_newbits     = var.tgw_subnet_newbits
  private_subnet_offset  = var.private_subnet_offset
  tgw_subnet_offset      = var.tgw_subnet_offset
  onprem_routes          = var.onprem_routes
  enable_s3_endpoint     = var.enable_s3_endpoint
  tags                   = var.tags
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "tgw_subnet_ids" {
  value = module.vpc.tgw_subnet_ids
}
