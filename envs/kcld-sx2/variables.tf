variable "prefix" {
  type    = string
  default = "kefe"
}

variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "azs" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "private_subnet_newbits" {
  type    = number
  default = 4
}

variable "tgw_subnet_newbits" {
  type    = number
  default = 8
}

variable "private_subnet_offset" {
  type    = number
  default = 7
}

variable "tgw_subnet_offset" {
  type    = number
  default = 0
}

variable "transit_gateway_id" {
  type    = string
  default = ""
}

variable "onprem_routes" {
  type = list(object({
    cidr        = string
    description = string
  }))
  default = []
}

variable "enable_s3_endpoint" {
  type    = bool
  default = true
}

variable "tags" {
  type    = map(string)
  default = {}
}
