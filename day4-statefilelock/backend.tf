terraform {
  backend "s3" {
    bucket = "newbuckfromdyno"
    key = "day4-statefilelock/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "lockstatedyno"
    encrypt = true
    
  }
}