module "sg_elb" {
  source = "github.com/terraform-community-modules/tf_aws_sg//sg_https_only"
  security_group_name = "${var.elb_sg_name}"
  vpc_id = "${module.vpc.vpc_id}"
  source_cidr_block = "${var.elb_whitelist_cidr}"
}

module "sg_web" {
  source = "github.com/terraform-community-modules/tf_aws_sg//sg_web"
  security_group_name = "${var.asg_sg_name}"
  vpc_id = "${module.vpc.vpc_id}"
  source_cidr_block = "${var.vpc_cidr}"
}
