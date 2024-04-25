# rds.tf - RDS instance for WordPress

resource "aws_db_instance" "wp_db" {
  identifier        = "wordpress-db"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  engine            = "mysql"
  engine_version    = "5.7"
  username          = "wp_user"
  password          = var.db_password
  db_name           = "wordpress"
  db_subnet_group_name      = aws_db_subnet_group.rds_subnet_group.name
  

  vpc_security_group_ids = [aws_security_group.rds_security_group.id]
  
  publicly_accessible = false

  tags = {
    Name = "WordPress Database"
  }
}

resource "aws_security_group" "rds_security_group" {
  name        = "rds-security-group"
  description = "Security group for RDS instance"
  vpc_id      = aws_vpc.wordpress.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.100.0.0/16"]
  }

  tags = {
    Name = "RDS Security Group"
  }
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = [aws_subnet.private1.id, aws_subnet.private2.id]
}