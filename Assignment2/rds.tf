

resource "aws_db_instance" "RDS" {
  identifier           = "mydbinstance"
  allocated_storage    = 20  # Size of the storage (in GB)
  storage_type         = "gp2"  # Storage type (General Purpose SSD)
  engine               = "mysql"  # Database engine
  engine_version       = "5.7"  # Engine version
  instance_class       = "db.t3.micro"  # Instance type
  username             = "ankuradarsh"  # Master username
  password             = "password123"  # Master password
  port = 3306
  publicly_accessible  = true
  multi_az             = false
  skip_final_snapshot  = true
  db_subnet_group_name   = aws_db_subnet_group.my_subnet_group.name
  
  vpc_security_group_ids = [aws_security_group.ssh.id]
  
  tags = {
    Name = "RDS database"
    Environment = "Dev/Test"
  }
}


output "rds_endpoint" {
  value = aws_db_instance.RDS.endpoint
}