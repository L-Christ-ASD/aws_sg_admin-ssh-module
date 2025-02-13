provider "aws" {
    region = "us-east-1"
}


variable "ec2_type" {
  description = "le type d'instance souhaité"
  type        = string
  default     = "t3.micro"
}

variable "counterInstance" {
    description = "Nombre d'instance a creer"
    #type = string
    default = 1
}

resource "aws_instance" "terrafom" {

  count = var.counterInstance # creation multiple des instances
  ami                    = "ami-04b4f1a9cf54c11d0"
  instance_type          = var.ec2_type
  key_name               = "vockey"
  vpc_security_group_ids = ["sg-0c091d51cee0301ef"]
  security_groups = [aws_security_group.admin_ssh.name]

  tags = {
    Name = "terrafom-${count.index}"
  }

}

output "public_ip_vm0" {
    value = aws_instance.terrafom[*].public_ip
  
}
output "isntance_id" {
    value = aws_instance.terrafom[*].id
  
}
#_____________Creation de security group___________
# =================================================
resource "aws_security_group" "admin_ssh" {
  name        = "admin-ssh"
  #description = "groupe-de sécurité pour accès ssh"
  vpc_id      = "vpc-03c855deae9233889"  


  tags = {
    Name = "admin-ssh"
  }
}

variable "admin-ips" {
  description = "les ip's des admins"
  default = ["8.8.8.8", "1.1.1.1"]
}

variable "mon_ip" {
  description = "Les adresses acceptéés"
  type = string
  default = "0.0.0.0/32"
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_in" {
  security_group_id = aws_security_group.admin_ssh.id
  cidr_ipv4         = "${var.mon_ip}/32"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_in" {
  for_each = toset(var.admin-ips)
  security_group_id = aws_security_group.admin_ssh.id
  cidr_ipv4         = "${each.value}/32"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_ssh_out" {
  security_group_id = aws_security_group.admin_ssh.id
  ip_protocol       = "-1" 
}

output "sg_name" {
    value = aws_security_group.admin_ssh.name 
}
output "sg_id" {
    value = aws_security_group.admin_ssh.id
}