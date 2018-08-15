#-------------------------------------------------
# All outputs are mentiond here for better clarity
#--------------------------------------------------

output "Elb_Endpoint" {
  value = "${aws_elb.app_loadbalancer.dns_name}"
}

output "ALB_Endpoint" {
 value = "${aws_lb.wordpress_alb.dns_name}"
}

output "vpc_id" {
  value = "${aws_vpc.wordpress_vpc.id}"
}

output "vpc_cidr" {
  value = "${aws_vpc.wordpress_vpc.cidr_block}"
}

output "Mysql_Endpoint" {
  value = "${aws_db_instance.mysql_db.endpoint}"
}
