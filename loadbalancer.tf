#---------------------------------------------------------------------
# classic load balancer that will load balance traffic on
# Wordpress machines running inside a ASG.
#----------------------------------------------------------------------

resource "aws_elb" "app_loadbalancer" {
  name = "wordpressLB"
  subnets = ["${aws_subnet.public1.id}","${aws_subnet.public2.id}"]
  security_groups = ["${aws_security_group.elb_sg.id}"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "TCP:80"
    interval            = 30
  }

  cross_zone_load_balancing   = true
  idle_timeout                = 200
  connection_draining         = true
  connection_draining_timeout = 300

  tags {
    Name = "app-elb"
  }

  depends_on = ["aws_security_group.elb_sg"]
}
