terraform {
  backend "s3" {
    bucket = "my-first-bucket-by-terraform3232"
    key    = "shreepal/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-lock"
  }
}
