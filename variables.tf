variable "prefix" {
  description = "Naming prefix: kefe (pilot) or efe (production)"
  type        = string
  default     = "kefe"

  validation {
    condition     = contains(["kefe", "efe"], var.prefix)
    error_message = "Prefix must be kefe (pilot) or efe (production)."
  }
}

variable "project" {
  description = "Project name (e.g. data, sapbw)"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g. dev, qa, prd, ops)"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR block (e.g. 10.91.0.0/20)"
  type        = string

  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "vpc_cidr must be a valid CIDR block."
  }
}

variable "azs" {
  description = "List of Availability Zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "private_subnet_newbits" {
  description = "Number of additional bits for private subnets (e.g. 4 for /24 from /20)"
  type        = number
  default     = 4
}

variable "tgw_subnet_newbits" {
  description = "Number of additional bits for TGW subnets (e.g. 8 for /28 from /20)"
  type        = number
  default     = 8
}

variable "tgw_subnet_offset" {
  description = "Starting netnum offset for TGW subnets to avoid overlap with private subnets"
  type        = number
  default     = 0
}

variable "private_subnet_offset" {
  description = "Starting netnum offset for private subnets"
  type        = number
  default     = 7
}

variable "transit_gateway_id" {
  description = "Transit Gateway ID for routing. Empty string disables TGW routes."
  type        = string
  default     = ""
}

variable "onprem_routes" {
  description = "List of on-premises CIDR routes via Transit Gateway"
  type = list(object({
    cidr        = string
    description = string
  }))
  default = [
    { cidr = "10.1.71.0/24", description = "VPN Derby Piso 2" },
    { cidr = "12.1.71.0/24", description = "VPN Derby secundario" },
    { cidr = "10.125.0.0/16", description = "Red corporativa EFE" },
    { cidr = "10.130.0.0/16", description = "Red corporativa EFE" },
  ]
}

variable "enable_s3_endpoint" {
  description = "Create S3 Gateway VPC Endpoint"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Additional tags to apply to all resources"
  type        = map(string)
  default     = {}
}
