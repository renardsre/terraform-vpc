variable "ami_id" {
  type    = string
  default = ""
}

variable "machine_type" {
  type    = string
  default = ""
}

variable "subnet_id" {
  type    = string
  default = ""
}

variable "key_name" {
  type    = string
  default = ""
}

variable "instance_name" {
  type    = string
  default = ""
}

variable "environment" {
  type    = string
  default = ""
}

variable "security_group_ids" {
  type    = list(any)
  default = []
}

variable "ip_private" {
  type    = string
  default = ""
}

variable "volume_type" {
  type    = string
  default = ""
}

variable "volume_size" {
  type    = number
  default = null
}