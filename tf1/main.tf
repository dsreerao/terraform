resource "aws_instance" "insname" {
    ami = var.ami_id
    instance_type = var.ins_type
    key_name = var.keypair
    tags = {
      name = "terror"
    }
}