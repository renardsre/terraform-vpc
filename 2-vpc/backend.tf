terraform {

  backend "s3" {
    profile                = "default"
    bucket                 = "tfstate-bucket"
    region                 = "ap-southeast-3"
    key                    = "production/vpc/terraform.tfstate"
    dynamodb_table         = "tf-lock"
    encrypt                = true
    skip_region_validation = true
  }

}
