# VPC
resource "aws_vpc" "example_vpc" {
  cidr_block           = "10.1.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "example_vpc"
  }
}

# サブネット
resource "aws_subnet" "public_0" {
  vpc_id                  = aws_vpc.example_vpc.id
  cidr_block              = "10.1.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-northeast-1a"
}

resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.example_vpc.id
  cidr_block              = "10.1.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-northeast-1c"
}

# インターネットゲートウェイ
resource "aws_internet_gateway" "example" {
  vpc_id = aws_vpc.example_vpc.id
}

# ルートテーブル
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.example_vpc.id
}

# ルート
resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  gateway_id             = aws_internet_gateway.example.id
  destination_cidr_block = "0.0.0.0/0"
}

# ルートテーブルの関連付け
resource "aws_route_table_association" "public_0" {
  subnet_id      = aws_subnet.public_0.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_1" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public.id
}
