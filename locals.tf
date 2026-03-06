locals {
  name_prefix = "${var.prefix}-${var.project}-${var.environment}"

  common_tags = merge(
    {
      Project     = var.project
      Environment = var.environment
      Prefix      = var.prefix
      ManagedBy   = "terraform"
      Module      = "kefe-terraform-aws-vpc"
    },
    var.tags,
  )

  enable_tgw = var.transit_gateway_id != ""
}
