module "vpc" {
  source               = "github.com/terraform-community-modules/tf_aws_vpc"
  name                 = "${var.vpc_name}"
  cidr                 = "${var.vpc_cidr}"
  public_subnets       = "${var.public_subnets}"
  private_subnets      = "${var.private_subnets}"
  azs                  = "${var.availability_zones}"
  enable_dns_hostnames = "true"
  enable_dns_support   = "true"
}
