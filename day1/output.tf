output "public" {
    value = aws_instance.insname.public_ip
  
}
output "aminame" {
    value = aws_instance.insname.ami
    sensitive = true
}
output "private" {
    value = aws_instance.insname.private_ip
  
}