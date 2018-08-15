#### This repo contains terraform code for setting up AWS environment for a wordpress application and rds.

##### Resources created by running this:
1. VPC
2. 6 Subnets(2Public, 2Application, 2DB)
3. Internet Gateway
4. NACLs
5. RouteTables
6. NatGateway
7. Autoscaling group
8. ELB(Natively supported)
9. Launch configuration
10. RDS with mysql, etc,
11. ALB(Added later)

This will creates 29 resources in total.

##### How to use

1. Clone repo
2. Add your AWS credentials in vars.tf file
3. Run "terraform apply"
4. On successful execution this will return ELB_Endpoint, hit that and access you application.

##### For destruction:
1. Run "terraform  destroy -force"

NOTE: All resources are selected in free tire.
- For DB version and sizing modify rds.tf file as per need.
- For ASG related parameters change modify autoscling.tf.


:) :)
