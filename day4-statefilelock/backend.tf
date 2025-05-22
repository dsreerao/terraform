terraform {
  backend "s3" {
    bucket = "newbuckfromdyno"
    key = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "lockstatedyno"
    encrypt = true
    
  }
}