terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "ec2-iac-aula2" {
  ami = "ami-0e86e20dae9224db8"
  instance_type = "t2.micro"

  tags = {
    Name = "ec2-iac-aula2"

  }

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 30
    volume_type = "gp3"
  }

  security_groups = [aws_security_group.sg_aula_iac.name, "default"]

  key_name = "aula_iac"
   // caso queira indicar uma subnet da aws 
  // subnet_id = "subnet-0f815adb41c54d577" // Subnet padrão da região us-east-1

  // assim é caso queira indicar uma subnet criada em arquivos .tf  
  subnet_id = aws_subnet.minha_subrede.id
}

variable "porta_hhtp" {
  description = "porta_http"
  default = 80
  type = number
}

resource "aws_security_group" "sg_aula_iac" {
  name = "sg_aula_iac"

  # entrada ssh do IP da região
  # consultando os IPs das regiões:
  # e
  ingress {
    from_port = var.porta_hhtp
    to_port = var.porta_hhtp
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   egress {
    from_port = var.porta_hhtp
    to_port = var.porta_hhtp
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_subnet" "minha_subrede" {
  vpc_id = "subnet-0f815adb41c54d577"
  cidr_block = "10.10.10.0/24"
}