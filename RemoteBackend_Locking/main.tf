provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "buck" {
  bucket = "my-first-bucket-by-terraform3232"
}

resource "aws_dynamodb_table" "terraform_lock" {
  name           = "terraform-lock"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}