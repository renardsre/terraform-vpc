variable "aws_region" {
  type    = string
  default = "ap-southeast-3"
}

variable "aws_credential_file" {
  type    = string
  default = "~/.aws/credentials"
}

variable "aws_credential_profile" {
  type    = string
  default = "default"
}

variable "aws_skip_region_validation" {
  type    = bool
  default = true
}

# tfstate bucket public access policy

variable "block_all_public_access_tfstate" {
  type    = bool
  default = true
}

variable "block_public_acls_tfstate" {
  type    = bool
  default = true
}

variable "block_public_policy_tfstate" {
  type    = bool
  default = true
}

variable "ignore_public_acls_tfstate" {
  type    = bool
  default = true
}

variable "restrict_public_buckets_tfstate" {
  type    = bool
  default = true
}
