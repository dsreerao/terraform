#first resource block first line should be written to call the block in command
#next directly run command  - terraform import aws_instance.importins i-0cdc2e2f5afd1cb32(instance id that created already)
#then state file is created 
#now fill the resource block ami,instancetype,key,tag
#now run plan 0 changes then import is succesuful
#now u can control manual resources through terraform
resource "aws_instance" "importins" { 
    ami = "ami-0953476d60561c955"
    instance_type = "t2.micro"
    key_name = "tfk"
    tags = {
      Name = "test"
    }

}