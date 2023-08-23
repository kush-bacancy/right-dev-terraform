resource "aws_instance" "public_instance" {
  ami           = var.ami  # Replace with your desired AMI ID
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.pub_sub1.id
  security_groups = [aws_security_group.webserver_sg.id]

  tags = {
    Name = "PublicInstance"
  }
}

resource "aws_instance" "private_instance" {
  ami           = var.ami  # Replace with your desired AMI ID
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.prv_sub1
  security_groups = [aws_security_group.webserver_sg.id]

  tags = {
    Name = "PrivateInstance"
  }
}