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
  ami           = "ami-0d593311db5abb72b"
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
    public_key = file("elk-key-pair.pub")
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