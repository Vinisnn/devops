terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  alias = "us-east-2"
  region = "us-east-2"
}

# Create a VPC. É o ambiente para os dev
resource "aws_instance" "dev" {
    count = 3 # É o numero de máquinas que eu vou criar
    ami = "ami-09e67e426f25ce0d7" # No campo AMI eu sempre coloco a imagem da maquina
    instance_type = "t2.micro"   # É o tipo de instancia, que nesse caso é a gratuita.
    key_name = var.keys  # Essa é a chave gerada no SSH local. PAra não ficar preso a AWS, é melhor assim
    tags = {
        Name = "dev${count.index}" # Variavel utilizada para criar a quantidade de máquinas de uma vez utilizada no count
    }
    vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}"] # ID do security pego da AWS
}

resource "aws_instance" "dev4" {
    ami = "ami-09e67e426f25ce0d7"
    instance_type = "t2.micro"
    key_name = var.keys
    tags = {
      Name = "dev4"
    }
    vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}"]
    depends_on = [aws_s3_bucket.dev4] # Atribuindo um recurso ao outro. 
}

resource "aws_instance" "dev5" {
    ami = var.amis["us-east-1"]
    instance_type = "t2.micro"
    key_name = var.keys
    tags = {
      Name = "dev5"
    }
    vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}"]
}

# dev6 foi para o provedor us-east-2 em um security group diferente junto com um banco dynamo. 
resource "aws_instance" "dev6" {
    provider = aws.us-east-2
    ami = var.amis["us-east-2"]
    instance_type = "t2.micro"
    key_name = var.keys
    tags = {
      Name = "dev6"
    }
    vpc_security_group_ids = ["${aws_security_group.acesso-ssh-2.id}"]
    depends_on = [aws_dynamodb_table.dynamodb]
}

resource "aws_instance" "dev7" {
    ami = var.amis["us-east-1"]
    instance_type = "t2.micro"
    key_name = var.keys
    tags = {
      Name = "dev7"
    }
    vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}"]
}

resource "aws_s3_bucket" "dev4" {
  bucket = "teste-dev4" # Nome do bucket
  acl = "private"  # ACL é o permissionamento do recurso

  tags = {
    Name = "teste-dev4"
  }
  
}

# CRIAÇÃO DE UM BANCO DE DADOS PARA A US-EAST-2
resource "aws_dynamodb_table" "dynamodb" {
  provider = aws.us-east-2
  name           = "dynamodb"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "UserId"
  range_key      = "GameTitle"

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "GameTitle"
    type = "S"
  }
}