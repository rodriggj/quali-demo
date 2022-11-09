module "ec2_instance" {
    source = "terraform-aws-modules/ec2-instance/aws"
    version = "3.0"
    name = "elk-demo"
    ami = "ami-0d593311db5abb72b"
    key_name = aws_key_pair.elk-key.key_name
    instance_type = "m4.large"
    vpc_security_group_ids = [aws_security_group.allow_elk.id]
    depends_on = [
      aws_security_group.allow_elk
    ]
    tags = {
        terraform = true
        environment = "dev"
    }
}

resource "aws_key_pair" "elk-key"{
    key_name = "elk-key"
    public_key = file("${path.module}/myKey.pem")
}

resource "aws_security_group" "allow_elk" {
    name        = "allow_elk"
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
        Name = "allow_tls"
    }
}
