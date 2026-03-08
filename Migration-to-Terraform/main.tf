provider "aws" {
  region = "us-east-1"
}

# import {
#   id = "i-0699a528becfa1ade"
#   to = aws_instance.example
# }

resource "aws_instance" "example" {
  ami                                  = "ami-0b6c6ebed2801a5cb"
  associate_public_ip_address          = true
  availability_zone                    = "us-east-1f"
  disable_api_stop                     = false
  disable_api_termination              = false
  ebs_optimized                        = true
  force_destroy                        = false
  get_password_data                    = false
  hibernation                          = false
  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "t3.micro"
#   / ************* other configuration you can add through the generate config file ******************************
  }

