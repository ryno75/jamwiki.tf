resource "template_file" "user_data" {
  template = "${file("${path.module}/data/userdata/default.tpl")}"
  vars {
    aws_region = "${var.aws_region}"
    env        = "${var.environment}"
  }
}

module "wiki_autoscaling_group" {
  source                          = "github.com/ryno75/tf_aws_asg_elb"
  lc_name                         = "${var.aslc_name}"
  ami_id                          = "${lookup(var.amazon_ami, var.aws_region)}"
  instance_type                   = "${var.asg_instance_type}"
  iam_instance_profile            = "${aws_iam_instance_profile.asg_instance_profile.name}"
  key_name                        = "${var.key_name}"
  security_group                  = "${module.sg_wiki.security_group_id_web}"
  user_data                       = "${template_file.user_data.rendered}"
  asg_name                        = "${var.asg_name}"
  asg_instance_name               = "${var.asg_instance_name}"
  asg_number_of_instances         = "${var.asg_number_of_instances}"
  asg_minimum_number_of_instances = "${var.asg_min_number_of_instances}"
  load_balancer_names             = "${module.wiki_elb.elb_name}"
  health_check_type               = "${var.asg_health_check_type}"
  health_check_grace_period       = "${var.asg_health_check_grace_period}"
  availability_zones              = "${var.availability_zones}"
  vpc_zone_subnets                = "${module.vpc.private_subnets}"
}

module "bastion" {
  source           = "github.com/ryno75/tfm_aws_bastion_asg"
  ami_id           = "${lookup(var.amazon_ami, var.aws_region)}"
  aws_region       = "${var.aws_region}"
  instance_type    = "${var.bastion_instance_type}"
  instance_profile = "${aws_iam_instance_profile.bastion_instance_profile.name}"
  key_name         = "${var.key_name}"
  security_group   = "${aws_security_group.sg_bastion.id}"
  subnet_ids       = "${module.vpc.public_subnets}"
  user_data        = "${template_file.user_data.rendered}"
}
