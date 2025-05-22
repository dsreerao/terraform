resource "aws_instance" "name" {
    ami = "ami-0953476d60561c955"
    instance_type = "t2.micro"
    key_name = "tfk"
    availability_zone = "us-east-1b"  
}

