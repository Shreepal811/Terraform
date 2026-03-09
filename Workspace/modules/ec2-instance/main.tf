provider "aws" {
  region = "us-east-1"
}

variable "ami_value" {
  description = "Value of ami"
}

variable "instance_type" {
  description = "Instance type of ec2"
  type = map(string)

  default = {
    "dev" = "t3.micro",
    "stage" = "t3.small",
    "prod" = "c7i-flex.large"
  }
}

resource "aws_instance" "example" {
  ami = var.ami_value
  instance_type = lookup(var.instance_type,terraform.workspace,"t3.micro")
}