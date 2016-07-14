module "wiki_elb" {
  source              = "github.com/terraform-community-modules/tf_aws_elb/elb_https"
  elb_name            = "${var.elb_name}"
  subnet_az1          = "${element(split(",",var.public_subnets),0)}"
  subnet_az2          = "${element(split(",",var.public_subnets),1)}"
  backend_port        = "${var.elb_instance_port}"
  backend_protocol    = "${var.elb_instance_protocol}"
  ssl_certificate_id  = "${var.elb_certificate_arn}"
  health_check_target = "${var.elb_health_check}"
}
