resource "aws_instance" "ec2_example" {

    ami = "ami-0d593311db5abb72b"  
    instance_type = "m4.large" 
    key_name= "elk-key-demo4"
    vpc_security_group_ids = [aws_security_group.allow_elk.id]
    depends_on = [
      aws_security_group.allow_elk
    ]

    tags = {
        terraform = true
        environment = "dev"
        name = "torque-elk-stack"
    }

  provisioner "remote-exec" {
    inline = [
      "touch hello.txt",
      "echo helloworld remote provisioner >> hello.txt",
    ]
  }
  connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ec2-user"
      private_key = file("${path.module}/elk-key-demo4")
      timeout     = "4m"
   }
}

resource "aws_key_pair" "elk-key-demo4"{
    key_name = "elk-key-demo4"
    public_key = file("${path.module}/elk-key-demo4.pub")
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
        Name = "allow_elk"
    }
}
