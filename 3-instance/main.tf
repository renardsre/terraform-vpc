resource "aws_key_pair" "key_instance" {
  key_name   = local.key_name
  public_key = file("public.key")
}

module "instance" {

  instance_name      = local.instance_name
  environment        = local.environment
  machine_type       = local.machine_type
  subnet_id          = data.aws_subnet.public_subnet[0].id
  ip_private         = local.ip_private
  security_group_ids = [data.aws_security_group.main.id]
  key_name           = aws_key_pair.key_instance.key_name
  volume_type        = local.volume_type
  volume_size        = local.volume_size

}

resource "aws_security_group_rule" "ingress_rules_22" {

  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["16.0.1.0/24", "16.0.11.0/24", "16.0.12.0/24"]
  description       = "open port 22 for internal server"
  security_group_id = data.aws_security_group.default.id

}
