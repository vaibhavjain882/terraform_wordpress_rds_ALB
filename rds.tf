#------------------------------------
# MYSQL creation and settings
#------------------------------------

# Subnet group for Mysql for HA
resource "aws_db_subnet_group" "mysql_db_subnet_group" {
  name       = "main"
  subnet_ids = ["${aws_subnet.db1.id}","${aws_subnet.db2.id}"]

  tags {
    Name = "Wordpress mysql subnet group"
  }
  depends_on = ["aws_subnet.db1", "aws_subnet.db2"]
}

# RDS isntance creation
resource "aws_db_instance" "mysql_db" {
  db_subnet_group_name = "${aws_db_subnet_group.mysql_db_subnet_group.name}"
  identifier           = "${var.db_identifier}"
  allocated_storage    = "20"
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "${var.db_name}"
  username             = "${var.db_user}"
  password             = "${var.db_password}"
  vpc_security_group_ids = ["${aws_security_group.db_sg.id}"]
  skip_final_snapshot = true #This is needed because if not enabled it will not allow terraform to destroy RDS
}

