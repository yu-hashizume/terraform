resource "aws_instance" "example_instance" {
  ami               = "ami-0c3fd0f5d33134a76"
  instance_type     = "t3.micro"
  availability_zone = "ap-northeast-1a"
  ebs_optimized     = false
  monitoring        = false
  # key_name = ""
  subnet_id = aws_subnet.public_0.id

  vpc_security_group_ids = [
    aws_security_group.ec2.id
  ]

  tags = {
    Name = "web1"
  }
}
