## 11. Create instance in public subnet

resource "aws_instance" "instances" {

  ami                    = var.ami_id == "" ? data.aws_ami.ubuntu.id : var.ami_id
  instance_type          = var.machine_type
  subnet_id              = var.subnet_id
  key_name               = var.key_name
  vpc_security_group_ids = var.security_group_ids
  private_ip             = var.ip_private
  user_data              = <<-EOF
                           #!/bin/bash
                           sudo apt update -y
                           sudo apt install nginx -y
                           sudo apt install -y php-fpm php-mysql mysql-server
                           sudo bash -c 'echo test terraform > /var/www/html/index.html'
                           EOF

  root_block_device {
    volume_type = var.volume_type
    volume_size = var.volume_size
  }

  tags = {
    Name        = var.instance_name,
    Environment = var.environment
  }
  
}
