resource "aws_security_group" "sg" {
  name        = "shared-sg"
 

  vpc_id = aws_vpc.wordpress.id
  ingress {
    from_port   = 80  
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  ingress {
    from_port   = 3306  
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24"] 
  }
}


resource "aws_vpc" "wordpress" {
  cidr_block = "10.100.0.0/16"
  tags = {
    Name = "wordpress-vpc"
  }
}

resource "aws_subnet" "public1" {
  vpc_id     = aws_vpc.wordpress.id
  cidr_block = "10.100.1.0/24"
  availability_zone = "eu-west-1a"

  tags = {
    Name = "public-1"
  }
}

resource "aws_subnet" "public2" {
  vpc_id     = aws_vpc.wordpress.id
  cidr_block = "10.100.2.0/24"
  availability_zone = "eu-west-1b"

  tags = {
    Name = "public-2"
  }
}

resource "aws_subnet" "private1" {
  vpc_id     = aws_vpc.wordpress.id
  cidr_block = "10.100.3.0/24"
  availability_zone = "eu-west-1a"

  tags = {
    Name = "private-1"
  }
}

resource "aws_subnet" "private2" {
  vpc_id     = aws_vpc.wordpress.id
  cidr_block = "10.100.4.0/24"
  availability_zone = "eu-west-1b"

  tags = {
    Name = "private-2"
  }
}

resource "aws_internet_gateway" "wordpress_igw" {
  vpc_id = aws_vpc.wordpress.id

  tags = {
    Name = "wordpress-igw"
  }
}

resource "aws_route_table" "wordpress_route_table" {
  vpc_id = aws_vpc.wordpress.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.wordpress_igw.id
  }

  tags = {
    Name = "wordpress-route-table"
  }
}
