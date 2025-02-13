# cretion of modules AWS security group -> terraform


## Cas d'utilisation du module admin-ssh


```hcl

provider "aws" {
    region = "us-east-1"
}


variable "counterInstance" {
    description = "Nombre d'instance a creer"
    #type = string
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
```

**Bonus**  

* Deployement sur le workspace de terraform_cloud (HCP Terraform), en decommentant dans main.tf le *terraform_cloud* 


*NB*:  

Dans cet exemple, les outputs sont: isntance_id et public_ip_vm

* -->  keep the **terraform.tfstate** in *.gitignore* in prod_env!