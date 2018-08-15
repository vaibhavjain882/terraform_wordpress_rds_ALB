#--------------------------------------------
# VPC, Subnets and IG
#---------------------------------------------

# VPC Creation
resource "aws_vpc" "wordpress_vpc" {
  cidr_block           = "${var.cidr}"
  instance_tenancy     = "default"

  tags {
    Name         = "${var.vpc_name}"
    environment  = "${var.environment}"
  }
}

# Internet Gateway creation
resource "aws_internet_gateway" "wordpress_ig" {
  vpc_id = "${aws_vpc.wordpress_vpc.id}"

  tags {
    Name = "wordpress_internetgateway"
    UseCase=  "demo"
  }
}

# Application Subnets creation
resource "aws_subnet" "app1" {
  vpc_id     = "${aws_vpc.wordpress_vpc.id}"
  cidr_block = "172.26.1.0/24"
  availability_zone = "${element(var.availability_zones, 0)}"

  tags {
    Name = "appSubnet1"
    SubnetType = "app"
    vpc_name = "${var.vpc_name}"
  }
  depends_on = ["aws_route_table.public_rt"]
}

resource "aws_subnet" "app2" {
  vpc_id     = "${aws_vpc.wordpress_vpc.id}"
  cidr_block = "172.26.2.0/24"
  availability_zone = "${element(var.availability_zones, 1)}"

  tags {
    Name = "appSubnet2"
    SubnetType = "app"
    vpc_name = "${var.vpc_name}"
  }
  depends_on = ["aws_route_table.public_rt"]
}


# Database Subnets creation
resource "aws_subnet" "db1" {
  cidr_block = "172.26.3.0/24"
  vpc_id = "${aws_vpc.wordpress_vpc.id}"
  availability_zone = "${element(var.availability_zones, 0)}"

  tags {
    Name = "dbSubnet1"
    SubnetType = "db"
    vpc_name = "${var.vpc_name}"
  }
}

resource "aws_subnet" "db2" {
  cidr_block = "172.26.4.0/24"
  vpc_id = "${aws_vpc.wordpress_vpc.id}"
  availability_zone = "${element(var.availability_zones, 1)}"

  tags {
    Name = "dbSubnet2"
    SubnetType = "db"
    vpc_name = "${var.vpc_name}"
  }
}

# ELB subnets creation
resource "aws_subnet" "public1" {
  cidr_block = "172.26.5.0/24"
  vpc_id = "${aws_vpc.wordpress_vpc.id}"
  availability_zone = "${element(var.availability_zones, 0)}"
  map_public_ip_on_launch = true

  tags {
    Name = "publicSubnet1"
    SubnetType = "public"
    vpc_name = "${var.vpc_name}"
  }
}

resource "aws_subnet" "public2" {
  cidr_block = "172.26.6.0/24"
  vpc_id = "${aws_vpc.wordpress_vpc.id}"
  availability_zone = "${element(var.availability_zones, 1)}"
  map_public_ip_on_launch = true

  tags {
    Name = "publicSubnet2"
    SubnetType = "public"
    vpc_name = "${var.vpc_name}"
  }
}