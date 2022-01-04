locals {

  aws_region                 = "ap-southeast-3"
  aws_credential_file        = "~/.aws/credentials"
  aws_credential_profile     = "default"
  aws_skip_region_validation = true

  vpc_name    = "main"
  environment = "production"

}
