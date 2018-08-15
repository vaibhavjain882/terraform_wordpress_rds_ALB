#-----------------------------------------------------------
# getting rds mysql db endpint using datasource
# this will be polulated in userdata of application server
#-----------------------------------------------------------

data "aws_db_instance" "wordpress_db" {
  db_instance_identifier = "${var.db_identifier}"
  depends_on = ["aws_db_instance.mysql_db"]
}
