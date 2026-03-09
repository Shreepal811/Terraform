variable "ami_value" {
  description = "value"
}

variable "instance_type" {
  description = "value"
  type = map(string)

  default = {
    "dev" = "t3.micro",
    "stage" = "t3.small",
    "prod" = "c7i-flex.large"
  }
}

module "example" {
  source = "./modules/ec2-instance"
  ami_value = var.ami_value
  instance_type = var.instance_type
}