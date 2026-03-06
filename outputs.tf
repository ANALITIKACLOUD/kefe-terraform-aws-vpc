output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.this.id
}

output "vpc_cidr" {
  description = "VPC CIDR block"
  value       = aws_vpc.this.cidr_block
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = aws_subnet.private[*].id
}

output "private_subnet_cidrs" {
  description = "List of private subnet CIDR blocks"
  value       = aws_subnet.private[*].cidr_block
}

output "tgw_subnet_ids" {
  description = "List of TGW subnet IDs"
  value       = aws_subnet.tgw[*].id
}

output "tgw_subnet_cidrs" {
  description = "List of TGW subnet CIDR blocks"
  value       = aws_subnet.tgw[*].cidr_block
}

output "private_route_table_id" {
  description = "Private route table ID"
  value       = aws_route_table.private.id
}

output "tgw_route_table_id" {
  description = "TGW route table ID"
  value       = aws_route_table.tgw.id
}

output "s3_endpoint_id" {
  description = "S3 Gateway VPC Endpoint ID"
  value       = var.enable_s3_endpoint ? aws_vpc_endpoint.s3[0].id : null
}
