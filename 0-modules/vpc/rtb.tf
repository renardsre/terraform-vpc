# this default route table created automatically after vpc created

resource "aws_default_route_table" "def_rtb" {

  count = var.stand_vpc && var.enable_internet_gateway ? 1 : 0

  default_route_table_id = aws_vpc.vpc[0].default_route_table_id

  tags = merge(
    {
      Name = "${var.vpc_name}-default-rtb"
      Env  = "${var.environment}"
    },
    var.tags,
    var.route_table_tags,
    var.default_rtb_tags,
  )

}

# route table with target as internet gateway

resource "aws_route_table" "pub_rtb" {

  count = var.enable_internet_gateway ? 1 : 0

  depends_on = [
    aws_vpc.vpc[0],
    aws_nat_gateway.single_nat_gateway,
  ]

  vpc_id = var.stand_vpc ? aws_vpc.vpc[0].id : var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.create_internet_gateway ? aws_internet_gateway.internet_gateway[0].id : var.internet_gateway_id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = var.create_internet_gateway ? aws_internet_gateway.internet_gateway[0].id : var.internet_gateway_id
  }

  tags = merge(
    {
      Name = "${var.vpc_name}-internet-rtb"
      Env  = "${var.environment}"
    },
    var.tags,
    var.route_table_tags,
    var.igw_rtb_tags,
  )

}


# route table with target as nat gateway

resource "aws_route_table" "single_nat_rtb" {

  count = var.enable_single_nat_gateway ? 1 : 0

  depends_on = [
    aws_vpc.vpc[0],
    aws_nat_gateway.single_nat_gateway,
  ]

  vpc_id = var.stand_vpc ? aws_vpc.vpc[0].id : var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.single_nat_gateway[0].id
  }

  tags = merge(
    {
      Name = "${var.vpc_name}-single-nat-rtb"
      Env  = "${var.environment}"
    },
    var.tags,
    var.route_table_tags,
    var.ngw_rtb_tags,
  )

}

resource "aws_route_table" "foreach_nat_rtb" {

  count = var.enable_foreach_nat_gateway && !var.enable_single_nat_gateway ? length(var.subnet_cidrs_public) : 0

  depends_on = [
    aws_vpc.vpc[0],
    aws_nat_gateway.foreach_nat_gateway,
  ]

  vpc_id = var.stand_vpc ? aws_vpc.vpc[0].id : var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.foreach_nat_gateway[count.index].id
  }

  tags = merge(
    {
      Name = "${var.vpc_name}-foreach-nat-rtb"
      Env  = "${var.environment}"
    },
    var.tags,
    var.route_table_tags,
    var.ngw_rtb_tags,
  )

}

# create public subnet route table association to internet route tables

resource "aws_route_table_association" "rta_public" {

  count = var.enable_internet_gateway || var.attach_public_subnet ? length(var.subnet_cidrs_public) : 0

  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.pub_rtb[0].id
  # route_table_id = !var.attach_public_subnet ? aws_route_table.pub_rtb[0].id : var.public_route_table_id

}

# create private subnet route table association to nat route tables

resource "aws_route_table_association" "single_rta_nat" {

  count = var.enable_single_nat_gateway && !var.enable_foreach_nat_gateway ? length(var.subnet_cidrs_private) : 0

  subnet_id      = element(aws_subnet.private_subnet.*.id, count.index)
  route_table_id = aws_route_table.single_nat_rtb[0].id

}

resource "aws_route_table_association" "foreach_rta_nat" {

  count = var.enable_foreach_nat_gateway && !var.enable_single_nat_gateway ? length(var.subnet_cidrs_private) : 0

  subnet_id      = element(aws_subnet.private_subnet.*.id, count.index)
  route_table_id = aws_route_table.foreach_nat_rtb[count.index].id

}
