resource "aws_subnet" "public_subnet" {

  count = var.stand_public_subnet ? length(var.subnet_cidrs_public) : 0

  vpc_id            = var.stand_vpc ? aws_vpc.vpc[0].id : var.vpc_id
  cidr_block        = var.subnet_cidrs_public[count.index]
  availability_zone = data.aws_availability_zones.azs.names[count.index]

  tags = merge(
    {
      Name = "${var.vpc_name}-pub-sub-${element(split("-", "${data.aws_availability_zones.azs.names[count.index]}"), 2)}",
      Env  = "${var.environment}"
    },
    var.tags,
    var.subnet_tags,
    var.public_subnet_tags,
  )

}

resource "aws_subnet" "private_subnet" {

  count = var.stand_private_subnet ? length(var.subnet_cidrs_private) : 0

  vpc_id            = var.stand_vpc ? aws_vpc.vpc[0].id : var.vpc_id
  cidr_block        = var.subnet_cidrs_private[count.index]
  availability_zone = data.aws_availability_zones.azs.names[count.index]

  tags = merge(
    {
      Name = "${var.vpc_name}-pvt-sub-${element(split("-", "${data.aws_availability_zones.azs.names[count.index]}"), 2)}",
      Env  = "${var.environment}"
    },
    var.tags,
    var.subnet_tags,
    var.private_subnet_tags,
  )

}
