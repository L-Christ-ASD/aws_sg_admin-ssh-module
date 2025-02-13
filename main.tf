# terraform { 
#   cloud { 
    
#     organization = "Nornes" 

#     workspaces { 
#       name = "Christ-asd" 
#     } 
#   } 
# }


provider "aws" {
 region = "us-east-1"
}


variable "counterInstance" {
    description = "Nombre d'instance à creer"
    default = 3
}

variable "ec2_type" {
  description = "le type d'instance souhaité"
  type        = string
  default     = "t3.micro"
}

module "admin_ssh_sg" {
  source = "./modules/aws_sg_admin_ssh"
  vpc_id = "vpc-03c855deae9233889"
}

resource "aws_instance" "terrafom" {

  count = var.counterInstance # creation multiple des instances
  ami                    = "ami-04b4f1a9cf54c11d0"
  instance_type          = var.ec2_type
  key_name               = "vockey"
  vpc_security_group_ids = [module.admin_ssh_sg.sg_id]
  #vpc_security_group_ids = "sg-0c091d51cee0301ef"
  #security_groups = [module.admin_ssh_sg.sg_id]

  tags = {
    Name = "terrafom-${count.index}"
  }

}

output "public_ip_vm" {
    value = aws_instance.terrafom[*].public_ip
  
}
output "isntance_id" {
    value = aws_instance.terrafom[*].id
  
}