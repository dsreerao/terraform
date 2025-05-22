terraform {
  backend "s3" {
    bucket = "pterraformbuck"
    key = "terraform.tfstate"
    region = "us-east-1"
    
  }
}