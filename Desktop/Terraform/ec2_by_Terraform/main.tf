data "aws_subnet" "existing"{
  id = "subnet-0797fdf5a2690aebf"
}

data "aws_security_group" "existing"{
  id = "sg-07ad346a7fe4b8ebb"
}

resource "aws_instance" "example" {
  ami           = "ami-0ecb62995f68bb549"
  instance_type = "m7i-flex.large"
  subnet_id = data.aws_subnet.existing.id
  vpc_security_group_ids = [data.aws_security_group.existing.id]
  associate_public_ip_address = true
  key_name = "new-aws"

  tags = {
    Name = "Jenkins"
  }
}

