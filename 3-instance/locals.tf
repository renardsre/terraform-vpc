locals {

  aws_region                 = "ap-southeast-3"
  aws_credential_file        = "~/.aws/credentials"
  aws_credential_profile     = "default"
  aws_skip_region_validation = true

  data_public_subnet_name  = ""
  data_private_subnet_name = "main-pvt-sub-3a"
  data_security_group_name = "sg-default"

  instance_name = "main-instance"
  environment   = "production"
  machine_type  = "t2.micro"
  ip_private    = "16.0.11.10"
  key_name      = "main-key"
  volume_type   = "gp2"
  volume_size   = 20

}
