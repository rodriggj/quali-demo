variable "ami" {
    description = "This is the AMI id of the amazon ec2 instance"
    type = string 
    default = "ami-0d593311db5abb72b"
}

variable "instance_type" {
    description = "This is the instance type of the ec2 instance"
    type = string 
    default = "m4.large"
}

variable "key_pair_name" {
    description = "This is the name of the key-pair listed on the ec2 dashboard"
    type = string 
    default = "tf-key-oregon"
}

