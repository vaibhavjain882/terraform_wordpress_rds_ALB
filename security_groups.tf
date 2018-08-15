#--------------------------------------------------------------------------------
# Restricted SGs, can be more restricted but I keep them minimal for demo purpose
#--------------------------------------------------------------------------------


# Application SG
resource "aws_security_group" "app_sg" {
  name        = "appSecurityGroup"
  description = "Application SG"
  vpc_id      = "${aws_vpc.wordpress_vpc.id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 65535
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

# Database SG
# NOTE: Self true will be needed if DB is setup in master-slave mode
resource "aws_security_group" "db_sg" {
  name        = "dbSecurityGroup"
  description = "allow traffic only from app subnet"
  vpc_id      = "${aws_vpc.wordpress_vpc.id}"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["${aws_subnet.app1.cidr_block}", "${aws_subnet.app2.cidr_block}"]
  }

  egress {
    from_port       = 0
    to_port         = 65535
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}


# Load balancer SG
resource "aws_security_group" "elb_sg" {
  name        = "elbSecurityGroup"
  description = "Allow all inbound traffic from anywhere"
  vpc_id      = "${aws_vpc.wordpress_vpc.id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks     = ["${aws_subnet.app1.cidr_block}", "${aws_subnet.app2.cidr_block}"]
  }
}