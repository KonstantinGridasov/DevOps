provider "aws" {
  region                  = var.aws_region
  shared_credentials_file = "~/.aws/credentional"
  default_tags {
    tags = {
      "Environment" = "DEV",
      "Team"        = "VipIt",
      "DeployedBy"  = "Terraform",
      "Description" = "Deployment in aws "
      "OwnerEmail"  = "goodstyle@vipit.com"
    }
  }
}


resource "aws_instance" "my_server_tryon" {
  ami                    = "ami-09042b2f6d07d164a"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.security_group_sec.id]
  user_data              = file("data.sh")

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_security_group" "security_group_sec" {
  name        = "My WebServer Security Group_sec"
  description = "My Security Group"

  dynamic "ingress" {
    for_each = ["80", "443", "8000", "22"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

