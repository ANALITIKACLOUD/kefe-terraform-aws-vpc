################################################################################
# VPC
################################################################################

resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-vpc"
  })
}

################################################################################
# Private Subnets (back / workload)
################################################################################

resource "aws_subnet" "private" {
  count = length(var.azs)

  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(var.vpc_cidr, var.private_subnet_newbits, var.private_subnet_offset + count.index)
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = false

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-private-${var.azs[count.index]}"
    Tier = "private"
  })
}

################################################################################
# TGW Subnets
################################################################################

resource "aws_subnet" "tgw" {
  count = length(var.azs)

  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(var.vpc_cidr, var.tgw_subnet_newbits, var.tgw_subnet_offset + count.index)
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = false

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-tgw-${var.azs[count.index]}"
    Tier = "tgw"
  })
}

################################################################################
# Route Table — Private
################################################################################

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-rt-private"
  })
}

resource "aws_route_table_association" "private" {
  count = length(var.azs)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

resource "aws_route" "private_default_tgw" {
  count = local.enable_tgw ? 1 : 0

  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  transit_gateway_id     = var.transit_gateway_id
}

resource "aws_route" "private_onprem" {
  count = local.enable_tgw ? length(var.onprem_routes) : 0

  route_table_id         = aws_route_table.private.id
  destination_cidr_block = var.onprem_routes[count.index].cidr
  transit_gateway_id     = var.transit_gateway_id
}

################################################################################
# Route Table — TGW
################################################################################

resource "aws_route_table" "tgw" {
  vpc_id = aws_vpc.this.id

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-rt-tgw"
  })
}

resource "aws_route_table_association" "tgw" {
  count = length(var.azs)

  subnet_id      = aws_subnet.tgw[count.index].id
  route_table_id = aws_route_table.tgw.id
}

################################################################################
# S3 Gateway Endpoint
################################################################################

resource "aws_vpc_endpoint" "s3" {
  count = var.enable_s3_endpoint ? 1 : 0

  vpc_id            = aws_vpc.this.id
  service_name      = "com.amazonaws.${data.aws_region.current.id}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = [aws_route_table.private.id]

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-vpce-s3"
  })
}

data "aws_region" "current" {}
