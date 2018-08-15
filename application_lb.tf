#---------------------------------------
# Creating application ELB
#---------------------------------------
resource "aws_lb" "wordpress_alb" {
  name               = "wordpressalb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.elb_sg.id}"]
  subnets            = ["${aws_subnet.public1.id}","${aws_subnet.public2.id}"]
  enable_deletion_protection = false
  tags {
    Environment = "demo"
  }
}

#-----------------------------------------
# Creating target group for ALB
#-----------------------------------------

resource "aws_lb_target_group" "wordpress_target_group" {
  name     = "wordpressalbtg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.wordpress_vpc.id}"
  health_check {matcher = "200-399"}

}

#-------------------------------------------------------
# Create a new ALB Target Group attachment
--------------------------------------------------------
resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = "${aws_autoscaling_group.app_asg.id}"
  alb_target_group_arn   = "${aws_lb_target_group.wordpress_target_group.arn}"
}


#--------------------------------------------------
# Creating ALB listener
#--------------------------------------------------

resource "aws_lb_listener" "wordpress_listener" {
  load_balancer_arn = "${aws_lb.wordpress_alb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.wordpress_target_group.arn}"
    type             = "forward"
  }
}
