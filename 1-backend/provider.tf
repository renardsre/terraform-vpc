provider "aws" {

  region                  = var.aws_region
  shared_credentials_file = var.aws_credential_file
  profile                 = var.aws_credential_profile
  skip_region_validation  = var.aws_skip_region_validation
  
}
