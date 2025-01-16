#create private ec2 instance 
resource "aws_instance" "web1" {
  ami = "ami-0454e52560c7f5c55"
  instance_type = "t2.micro"
  key_name = "albkey"
  subnet_id = aws_subnet.private1.id
  security_groups = [aws_security_group.sg2.id]
  associate_public_ip_address = true
  user_data = file ("userdata.sh")
}

resource "aws_instance" "web2" {
  ami = "ami-0454e52560c7f5c55"
  instance_type = "t2.micro"
  key_name = "albkey"
  subnet_id = aws_subnet.private2.id
  security_groups = [aws_security_group.sg2.id]
  associate_public_ip_address = true
  user_data = file ("userdata.sh")
}

