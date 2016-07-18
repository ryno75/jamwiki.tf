module "sg_elb" {
  source = "github.com/terraform-community-modules/tf_aws_sg//sg_https_only"
  security_group_name = "${var.elb_sg_name}"
  vpc_id = "${module.vpc.vpc_id}"
  source_cidr_block = "${var.elb_whitelist_cidr}"
}

module "sg_wiki" {
  source = "github.com/terraform-community-modules/tf_aws_sg//sg_web"
  security_group_name = "${var.asg_sg_name}"
  vpc_id = "${module.vpc.vpc_id}"
  source_cidr_block = "${var.vpc_cidr}"
}

resource "aws_security_group" "sg_bastion" {
  name = "${var.bastion_sg_name}"
  description = "Allow inbound SSH traffic for whitelisted IPs"
  vpc_id = "${module.vpc.vpc_id}"
  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["${split(",", var.bastion_whitelist)}"]
  }
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "sg_rds" {
  name = "${var.rds_sg_name}"
  description = "Allow inbound DB client connections for wiki ASG instances"
  vpc_id = "${module.vpc.vpc_id}"
  ingress {
    from_port = "${var.database_port}"
    to_port =  "${var.database_port}"
    protocol = "tcp"
    security_groups = ["${module.sg_wiki.security_group_id_web}"]
  }
  ingress {
    from_port = "${var.database_port}"
    to_port =  "${var.database_port}"
    protocol = "tcp"
    cidr_blocks = ["${split(",", var.bastion_whitelist)}"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
