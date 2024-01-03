# main.tf
provider "aws" {
  region = "eu-west-3"
  access_key = "xx"
  secret_key = "xx"
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_security_group" "my_security_group" {
  vpc_id = aws_vpc.my_vpc.id

  // Règle pour permettre l'accès SSH depuis n'importe quelle adresse
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // Règle pour permettre l'accès HTTP depuis n'importe quelle adresse
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // Règle pour sortir tout le trafic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "my_instance" {
  ami             = "ami-02ea01341a2884771"
  instance_type   = "t2.micro"
  key_name        = var.instance_name
  vpc_security_group_ids = [aws_security_group.my_security_group.id]
  user_data       = <<-EOF
    #!/bin/bash
    # Votre script de configuration ici
  EOF

  tags = {
    Name = var.instance_name
  }
}
