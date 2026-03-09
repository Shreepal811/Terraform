// VPC
resource "aws_vpc" "CI-CD_VPC" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "python_VPC"
  }
}

// Subnet
resource "aws_subnet" "CI-CD_Subnet" {
  vpc_id = aws_vpc.CI-CD_VPC.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "python_Subnet"
  }
}

//IGW
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.CI-CD_VPC.id

  tags = {
    Name = "main"
  }
}

// Route Table
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.CI-CD_VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "rt"
  }
}

// Route Table Association
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.CI-CD_Subnet.id
  route_table_id = aws_route_table.rt.id
}

// Security Group
resource "aws_security_group" "CI-CD_SG" {
  description = "Allow application traffic"
  vpc_id      = aws_vpc.CI-CD_VPC.id


  ingress {
    description      = "Allow ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "Allow http port"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "python_SG"
  }
}



// EC2
resource "aws_instance" "example" {
  ami = var.ami_value
  key_name = var.key_file
  subnet_id = aws_subnet.CI-CD_Subnet.id
  vpc_security_group_ids = [aws_security_group.CI-CD_SG.id]
  instance_type = var.type

connection {
  type        = "ssh"
  user        = "ubuntu"
  private_key = file(var.key_path)
  host        = self.public_ip
}

  // File provisioner
  provisioner "file" {
  source = "app.py"
  destination = "/home/ubuntu/app.py"
}



    provisioner "remote-exec" {
  inline = [
    "sudo apt update -y",
    "sudo apt-get install -y python3-pip python3-venv python3-full",
    "python3 -m venv /home/ubuntu/venv",
    "/home/ubuntu/venv/bin/pip install flask",
    "sudo /home/ubuntu/venv/bin/python3 /home/ubuntu/app.py &"
  ]
}

  tags = {
    Name = "python"
  }
}

