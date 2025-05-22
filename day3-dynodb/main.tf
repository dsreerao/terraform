provider "aws" {
  region = "us-east-1"

}
resource "aws_s3_bucket" "buck" {
  bucket = "newbuckfromdyno"

}

resource "aws_dynamodb_table" "db" {
  name           = "lockstatedyno"
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20
  attribute {
    name = "LockID"
    type = "S"
  }
}
