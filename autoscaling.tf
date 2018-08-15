#--------------------------------------------------------------------
# Data source to create template file which will be used as user_data
#--------------------------------------------------------------------

data "template_file" "init_template" {
  template = "${file("${path.module}/user_data.sh")}"

  vars {
    db_name        = "${var.db_name}"
    db_host        = "${data.aws_db_instance.wordpress_db.address}"
    db_user        = "${var.db_user}"
    db_password    = "${var.db_password}"
    db_charset     = "${var.db_charset}"
    wordpress_url  = "${var.wordpress_url}"
  }
  depends_on = ["aws_db_instance.mysql_db"]
}

# ---------------------------------
# CREATE THE Launch Configuration
# ---------------------------------

resource "aws_launch_configuration" "app_lc" {
  name_prefix = "wordpress"
  image_id      = "${lookup(var.aws_ami_id, var.aws_region)}"
  instance_type = "t2.micro"
  security_groups = ["${aws_security_group.app_sg.id}"]
  user_data = "${data.template_file.init_template.rendered}"
  #key_name = "test"

  lifecycle {
    create_before_destroy = true
  }
  depends_on = ["aws_security_group.app_sg", "data.aws_db_instance.wordpress_db"]

}

# ------------------------------
# CREATE the Auto Scaling Group
# ------------------------------

resource "aws_autoscaling_group" "app_asg" {
  name                 = "wordpress_autoscaling_group"
  launch_configuration = "${aws_launch_configuration.app_lc.name}"
  min_size             = 2
  max_size             = 3
  load_balancers = ["${aws_elb.app_loadbalancer.name}"]
  vpc_zone_identifier = ["${aws_subnet.app1.id}","${aws_subnet.app2.id}"]

  depends_on = ["aws_elb.app_loadbalancer"]
}
