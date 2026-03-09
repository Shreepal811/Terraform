provider "aws" {
  region = "eu-north-1"
}
provider "aws" {
  alias = "eu-north-1"
  region = "eu-north-1"
}

provider "aws" {
  alias = "us-east-1"
  region = "us-east-1"
}


resource "aws_instance" "this" {
  ami                     = "ami-0ad50334604831820"
  instance_type           = "t3.micro"
  associate_public_ip_address = true
  key_name   = "new-aws"
  subnet_id = "subnet-0797fdf5a2690aebf"

  tags = {
    Name = "redhat3"
  }
  provider = aws.us-east-1

}

resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
  provider = aws.eu-north-1
}

resource "aws_subnet" "main" {
  vpc_id     = aws_default_vpc.default.id
  cidr_block = "172.31.1.0/24"

  tags = {
    Name = "Main"
  }
}