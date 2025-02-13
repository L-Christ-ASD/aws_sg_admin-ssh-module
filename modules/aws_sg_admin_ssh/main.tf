provider "aws" {
 region = "us-east-1"
}

#_____________Creation de security group___________
# =================================================
resource "aws_security_group" "admin_ssh" {
  name   = "admin-ssh"
  vpc_id = var.vpc_id

  tags = {
    Name = "admin-ssh"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_in" {
  security_group_id = aws_security_group.admin_ssh.id
  cidr_ipv4         = "${var.mon_ip}/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ins" {
  for_each          = toset(var.admin-ips)
  security_group_id = aws_security_group.admin_ssh.id
  cidr_ipv4         = "${each.value}/32"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_ssh_out" {
  security_group_id = aws_security_group.admin_ssh.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}