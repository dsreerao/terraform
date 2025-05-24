#creating vpc 
resource "aws_vpc" "vpcdev" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "custvpc"
  }

}
#creating subnet
resource "aws_subnet" "publicsubnet" {
  vpc_id     = aws_vpc.vpcdev.id
  cidr_block = "10.0.0.0/24"
  tags = {
    Name = "publicsub"
  }
}
#this is private subnet 
resource "aws_subnet" "privatesubnet" {
  vpc_id     = aws_vpc.vpcdev.id
  cidr_block = "10.0.0.0/24"
  tags = {
    Name = "privatesub"
  }
}
#create internetgateway and attach to vpc
resource "aws_internet_gateway" "igdev" {
  vpc_id = aws_vpc.vpcdev.id
  tags = {
    Name = "pubig"
  }
}
#create route table 
resource "aws_route_table" "rtdev" {
  vpc_id = aws_vpc.vpcdev.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igdev.id
  }

}


#subnet associate to route 
resource "aws_route_table_association" "pubass" {
  subnet_id      = aws_subnet.publicsubnet.id
  route_table_id = aws_route_table.rtdev.id
}


#create allocate ip for NAT
resource "aws_eip" "aip" {
  domain = "vpc"
}
#create nat gateway
resource "aws_nat_gateway" "natdev" {
  allocation_id = aws_eip.aip.id
  subnet_id     = aws_subnet.publicsubnet.id
  tags = {
    Name = "gw NAT"
  }
}
#creating private route table for nat
resource "aws_route_table" "privatert" {
  vpc_id = aws_vpc.vpcdev.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natdev.id
  }

}
#subnet associate to private route table
resource "aws_route_table_association" "privateass" {
  subnet_id      = aws_subnet.privatesubnet.id
  route_table_id = aws_route_table.privatert.id
}

#create security group

resource "aws_security_group" "sgdev" {
  name        = "sgdev"
  description = "allow"
  vpc_id      = aws_vpc.vpcdev.id

  ingress {
    description = "allow 80 port"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    description = "Allow 22"
    from_port   = 22
    to_port     = 22
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

#creating public server
resource "aws_instance" "pubserver" {
  ami                         = "ami-0953476d60561c955"
  instance_type               = "t2.micro"
  key_name                    = "tfk"
  subnet_id                   = aws_subnet.publicsubnet.id
  vpc_security_group_ids      = [aws_security_group.sgdev.id]
  associate_public_ip_address = true
  tags = {
    Name = "terraform"
  }

}
