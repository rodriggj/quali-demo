terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.39.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

variable "prefix" {
  description = "servername prefix"
  default = "gjr"
}

resource "aws_instance" "web" {
  ami           = "ami-017fecd1353bcc96e"
  instance_type = "m4.large"
  key_name= "elk-key-pair"
  count = 1
  vpc_security_group_ids = [
    aws_security_group.allow_elk.id
  ]
  user_data = "${file("elk_config.sh")}"
  tags = {
    Name = "${var.prefix}${count.index}"
  }
}

resource "aws_key_pair" "elk-key-pair"{
    key_name = "elk-key-pair"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDEXtSHNDteXEuZk3gmHGYkO1hUOliUhlZoKH7Q6RnVBbejOc7NUu/9Kr3MXlvlBANlAlsd/qHXepqMZXXQXksWi1JetvaOrTcivOzD+1g4Ep3mk7JHcFriMaAK63+6QNMCOjqCKuSRNc9EoF8KXd/JXHIDiJ4R0LGyOXC0vzPmbgX708HemcRwk3AlMsKjBkrh9MQWENDCH73PX1I5uU09TJL9pt8QAoSv6nhKhLd7xCeUFAQzkITyqyhpnCoKCJiBuPJ9a72+oZ0EwIoUHiJkY29IjGvvzUqCCCwY/0DZCFFj+hcV/L2inWS2nKuY5cUNNAcNX5igaZVh/k1T744F gabrielrodriguez@QS-US-MB-GABE.local"
}

resource "aws_security_group" "allow_elk" {
    name        = "elk-sg"
    description = "Allow all elasticsearch traffic"

    # elastisearch port
    ingress {
        from_port        = 9200
        to_port          = 9200
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
    }

    #kibana port
    ingress {
        from_port        = 5601
        to_port          = 5601
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
    }

    #logstash port
    ingress {
        from_port        = 5043
        to_port          = 5044
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
    }

    #ssh port
    ingress {
        from_port        = 22
        to_port          = 22
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
    }

    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    tags = {
        Name = "allow_elk"
    }
}

output "instances" {
  value       = "${aws_instance.web.*.private_ip}"
  description = "PrivateIP address details"
}