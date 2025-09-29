provider "aws" {
  region = var.region
}

resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Allow HTTP and SSH"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name = "web-app-server"
  }
}
 
 output "web_server_ip" {
  value = aws_instance.web.public_ip
}


resource "aws_instance" "web" {
  # your config here
}

