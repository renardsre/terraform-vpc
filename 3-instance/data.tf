data "aws_subnet" "public_subnet" {

  count = local.data_public_subnet_name != "" ? 1 : 0

  tags = {
    Name        = local.data_public_subnet_name
    Environment = local.environment
  }

}

data "aws_subnet" "private_subnet" {

  count = local.data_private_subnet_name != "" ? 1 : 0

  tags = {
    Name        = local.data_private_subnet_name
    Environment = local.environment
  }

}

data "aws_security_group" "main" {

  tags = {
    Name        = local.data_security_group_name
    Environment = local.environment
  }

}

data "aws_instance" "main" {

  tags = {
    Name        = local.instance_name
    Environment = local.environment
  }

}
