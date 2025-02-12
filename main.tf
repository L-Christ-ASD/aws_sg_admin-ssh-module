provider "dns" {}

provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "mon-bucket-demo-one"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

variable "ec2_type" {
  description = "le type d'instance souhaité"
  type        = string
  default     = "t3.micro"
}

variable "ec2_distribution" {
  description = "distribution par defaut"
  type        = string
  default  = "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-*"
}

variable "ec2_archi" {
  description = "Architecture de l'instance (amd64 ou arm64)"
  type        = string
  default     = "x86_64"
}

# Recupération automatique de l'AMI
data "aws_ami" "mylastestimage" {
  #executable_users = ["self"]
  most_recent = true
  owners      = ["099720109477"] # ou "amazon"

  filter {
    name   = "name"
    values = [var.ec2_distribution]
  }

  filter {
    name   = "architecture"
    values = [var.ec2_archi]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

output "ami_id" {
  value = data.aws_ami.mylastestimage.id
}
output "ami_name" {
  value = data.aws_ami.mylastestimage.name
}


resource "aws_instance" "terrafom" {

  # ami                    = "ami-04b4f1a9cf54c11d0"
  ami                    = data.aws_ami.mylastestimage.id
  instance_type          = var.ec2_type
  key_name               = "vockey"
  vpc_security_group_ids = ["sg-0c091d51cee0301ef"]

  tags = {
    Name = "inst_via_terraforme"
  }

}

resource "aws_s3_bucket" "bucket-terraf" {
  bucket = "mon-bucket-demo-one"
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.bucket-terraf.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Exemple de recupération de data

data "dns_a_record_set" "google" {
  host = "google.com"
}

output "google_addrs" {
  value = join(",", data.dns_a_record_set.google.addrs)
}

output "public_ip" {
  value = aws_instance.terrafom.public_ip
}

output "private_ip" {
  value = aws_instance.terrafom.private_ip
}