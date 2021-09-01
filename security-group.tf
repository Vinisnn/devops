resource "aws_security_group" "acesso-ssh" {
  name        = "acesso-ssh"
  description = "acesso-ssh"


  ingress {
      description      = "acesso-ssh"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = var.cidr_ips
  }
  tags = {
    Name = "ssh"
  }
}

resource "aws_security_group" "acesso-ssh-2" {
    provider = aws.us-east-2
    name = "acesso-ssh-2"
    description = "acesso-ssh-2"

    ingress {
        description = "acesso-ssh-2"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = var.cidr_ips
    }
    tags = {
        Name = "ssh"
    }
}
