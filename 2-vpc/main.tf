module "vpc" {

  source = "../0-modules/vpc"

  stand_vpc                = true
  vpc_name                 = local.vpc_name
  environment              = local.environment
  vpc_cidr                 = "16.0.0.0/16"
  vpc_enable_dns_support   = true
  vpc_enable_dns_hostnames = true

  stand_public_subnet  = true
  stand_private_subnet = true
  attach_public_subnet = true
  subnet_cidrs_public  = ["16.0.1.0/24"]
  subnet_cidrs_private = ["16.0.11.0/24", "16.0.12.0/24"]

  enable_internet_gateway   = true
  enable_nat_gateway        = true
  enable_single_nat_gateway = true

}

resource "aws_security_group" "main" {

  depends_on = [
    module.vpc
  ]

  vpc_id = data.aws_vpc.vpc.id
  name   = "default_sg"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "sg-default"
    Environment = local.environment
  }

}
