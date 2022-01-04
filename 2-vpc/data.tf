data "aws_vpc" "vpc" {

  depends_on = [
    module.vpc
  ]

  tags = {
    Name        = local.vpc_name
    Environment = local.environment
  }

}