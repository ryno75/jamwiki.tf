module "wiki_elb" {
  source              = "github.com/terraform-community-modules/tf_aws_elb/elb_https"
  elb_name            = "${var.elb_name}"
  elb_security_group  = "${aws_security_group.elb.id}"
  subnet_az1          = "${element(split(",",module.vpc.public_subnets),0)}"
  subnet_az2          = "${element(split(",",module.vpc.public_subnets),1)}"
  backend_port        = "${var.elb_instance_port}"
  backend_protocol    = "${var.elb_instance_protocol}"
  ssl_certificate_id  = "${var.elb_certificate_arn}"
  health_check_target = "${var.elb_health_check}"
  aws_access_key      = "${var.aws_access_key}"
  aws_secret_key      = "${var.aws_secret_key}"
  aws_region          = "${var.aws_region}"
}
