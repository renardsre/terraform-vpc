variable "vpc_name" {
  type    = string
  default = ""
}

variable "environment" {
  type    = string
  default = ""
}

variable "vpc_enable_dns_support" {
  type        = bool
  default     = true
}

variable "vpc_enable_dns_hostnames" {
  type        = bool
  default     = true
}

variable "vpc_cidr" {
  type = string
  default = ""
}

variable "subnet_cidrs_public" {
  type        = list(any)
  default     = []
}

variable "subnet_cidrs_private" {
  type        = list(any)
  default     = []
}

variable "create_internet_gateway" {
  type    = bool
  default = false
}

variable "enable_internet_gateway" {
  type    = bool
  default = false
}

variable "attach_internet_gateway" {
  type    = bool
  default = false
}

variable "internet_gateway_id" {
  type    = string
  default = ""
}

variable "public_route_table_id" {
  type    = string
  default = ""
}

variable "enable_single_nat_gateway" {
  type    = bool
  default = false
}

variable "enable_foreach_nat_gateway" {
  type    = bool
  default = false
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "vpc_tags" {
  type    = map(string)
  default = {}
}

variable "subnet_tags" {
  type    = map(string)
  default = {}
}

variable "public_subnet_tags" {
  type    = map(string)
  default = {}
}

variable "private_subnet_tags" {
  type    = map(string)
  default = {}
}

variable "internet_gateway_tags" {
  type    = map(string)
  default = {}
}

variable "nat_gateway_tags" {
  type    = map(string)
  default = {}
}

variable "route_table_tags" {
  type    = map(string)
  default = {}
}

variable "default_rtb_tags" {
  type    = map(string)
  default = {}
}

variable "igw_rtb_tags" {
  type    = map(string)
  default = {}
}

variable "ngw_rtb_tags" {
  type    = map(string)
  default = {}
}

variable "vpc_id" {
  type    = string
  default = ""
}

variable "stand_vpc" {
  type    = bool
  default = false
}

variable "stand_public_subnet" {
  type    = bool
  default = false
}

variable "attach_public_subnet" {
  type    = bool
  default = false
}

variable "stand_private_subnet" {
  type    = bool
  default = false
}

variable "attach_single_private_subnet" {
  type    = bool
  default = false
}