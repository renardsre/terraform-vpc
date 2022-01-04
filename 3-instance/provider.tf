provider "aws" {

  region                  = local.aws_region
  shared_credentials_file = local.aws_credential_file
  profile                 = local.aws_credential_profile
  skip_region_validation  = local.aws_skip_region_validation

}
