# セキュリティグループ
resource "aws_security_group" "ec2" {
  name        = "example"
  description = "test security group"
  vpc_id      = aws_vpc.example_vpc.id
  tags = {
    Name = "example_sg"
  }
}

# インバウンドルール
resource "aws_security_group_rule" "http" {
  security_group_id = aws_security_group.ec2.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = "80"
  to_port           = "80"
  cidr_blocks       = ["0.0.0.0/0"]
}

# アウトバウンドルール
resource "aws_security_group_rule" "alb-egress-ipv6" {
  security_group_id = aws_security_group.ec2.id
  type              = "egress"
  protocol          = "all"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
}
