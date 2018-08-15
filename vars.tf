#---------------------------------
# This file contains all variables
#---------------------------------

# Provide your account credentails
provider "aws" {
  access_key = ""
  secret_key = ""
  region = "us-east-1"
}

# Indsance Related Valiables
variable "wordpress_url" {
  default = "https://wordpress.org/latest.tar.gz"
}

variable "aws_ami_id" {
  type = "map"
  default = {
    "us-east-1" = "ami-759bc50a" // if using any other region add region and AMI ID
  }
}

# Data base related Vars
variable "db_identifier" {
  default = "vaibhav"
}

variable "db_name" {
  default = "vaibhav"
}

variable "db_user" {
  default = "root"
}

#Should be passed from commandline
variable "db_password" {
  default = "password"
}

variable "db_charset" {
  default = "utf8mb4"
}

# VPC related vars
variable "environment" {
  default = "wordpress_environment"
}

variable "vpc_name" {
  default = "wordpress_environment_vpc"
}

variable "cidr" {
  default = "172.26.0.0/16"
}

variable "aws_region" {
  description = "ec2 region for the vpc"
  default     = "us-east-1"
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = "list"
  default     = ["us-east-1a", "us-east-1b"]
}
