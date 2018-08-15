#--------------------------------------------------------------
# Natgateway for provideing Internet access to Private subnets
#--------------------------------------------------------------

# Elastic IP creation
resource "aws_eip" "natEip" {
  vpc = true
}

# Nat Gateway creation
# Creating only one for demo purpose
resource "aws_nat_gateway" "wordpress_environment_natgateway" {
  allocation_id = "${aws_eip.natEip.id}"
  subnet_id     = "${aws_subnet.public1.id}"

  depends_on = ["aws_internet_gateway.wordpress_ig","aws_eip.natEip", "aws_subnet.public1"]
}
