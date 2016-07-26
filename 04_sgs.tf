resource "aws_security_group" "elb" {
  name        = "${var.elb_sg_name}"
  description = "Allow inbound TCP ${var.elb_listener_port} traffic to ELB"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress {
    from_port   = "${var.elb_listener_port}"
    to_port     = "${var.elb_listener_port}"
    protocol    = "tcp"
    cidr_blocks = ["${split(",", var.elb_whitelist_cidr)}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "wiki" {
  name        = "${var.asg_sg_name}"
  description = "Allow inbound TCP ${var.elb_instance_port} traffic jamwiki server"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  ingress {
    from_port   = "${var.elb_instance_port}"
    to_port     = "${var.elb_instance_port}"
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "bastion" {
  name        = "${var.bastion_sg_name}"
  description = "Allow inbound SSH traffic for whitelisted IPs"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${split(",", var.bastion_whitelist)}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "rds" {
  name        = "${var.rds_sg_name}"
  description = "Allow inbound DB client connections for wiki ASG instances"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress {
    from_port       = "${var.database_port}"
    to_port         = "${var.database_port}"
    protocol        = "tcp"
    security_groups = ["${aws_security_group.wiki.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
