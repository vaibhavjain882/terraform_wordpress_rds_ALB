#-----------------------------------------------
# All Network ACLs are described in this file
#-----------------------------------------------

# Public Subnet ACLs
resource "aws_network_acl" "public_acl" {
  vpc_id = "${aws_vpc.wordpress_vpc.id}"
  subnet_ids = ["${aws_subnet.public1.id}","${aws_subnet.public2.id}"]

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535
  }

  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535
  }

  tags {
    Name = "public_nacl"
  }
}

# Application Subnet ACLs
resource "aws_network_acl" "app_acl" {
  vpc_id = "${aws_vpc.wordpress_vpc.id}"
  subnet_ids = ["${aws_subnet.app1.id}", "${aws_subnet.app2.id}"]

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535
  }

  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535
  }

  tags {
    Name = "app_nacl"
  }
}

# Database subnet ACLs
resource "aws_network_acl" "db_acl" {
  vpc_id = "${aws_vpc.wordpress_vpc.id}"
  subnet_ids = ["${aws_subnet.db1.id}","${aws_subnet.db2.id}"]

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "${aws_vpc.wordpress_vpc.cidr_block}"
    from_port  = 0
    to_port    = 65535
  }

  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535
  }

  tags {
    Name = "db_nacl"
  }
}
