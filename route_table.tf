#----------------------------------------------
# Route tables for all subnets are defined here
#----------------------------------------------

# Public Subnet route table
resource "aws_route_table" "public_rt" {
  vpc_id = "${aws_vpc.wordpress_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.wordpress_ig.id}"
  }

  tags {
    Name = "PublicRouteTable"
  }
}

# Private subnet route table
resource "aws_route_table" "private_rt" {
  vpc_id = "${aws_vpc.wordpress_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.wordpress_environment_natgateway.id}"
  }

  tags {
    Name = "private_rt"
  }
}

# Route table association wih subnets
resource "aws_route_table_association" "public_subnet_rt_sssociation_1" {
  subnet_id      = "${aws_subnet.public1.id}"
  route_table_id = "${aws_route_table.public_rt.id}"
}

resource "aws_route_table_association" "public_subnet_rt_sssociation_2" {
  subnet_id      = "${aws_subnet.public2.id}"
  route_table_id = "${aws_route_table.public_rt.id}"
}

resource "aws_route_table_association" "app_subnet_rt_association_1" {
  subnet_id      = "${aws_subnet.app1.id}"
  route_table_id = "${aws_route_table.private_rt.id}"
}

resource "aws_route_table_association" "app_subnet_rt_association_2" {
  subnet_id      = "${aws_subnet.app2.id}"
  route_table_id = "${aws_route_table.private_rt.id}"
}

resource "aws_route_table_association" "db_subnet_rt_association_1" {
  subnet_id = "${aws_subnet.db1.id}"
  route_table_id = "${aws_route_table.private_rt.id}"
}

resource "aws_route_table_association" "db_subnet_rt_association_2" {
  subnet_id = "${aws_subnet.db2.id}"
  route_table_id = "${aws_route_table.private_rt.id}"
}
