resource "aws_iam_role" "asg_instance_profile" {
  name               = "asg_instance_profile_role"
  path               = "/"
  assume_role_policy = "${file("${path.module}/data/policies/ec2_assume_role.json")}"
}

resource "aws_iam_instance_profile" "asg" {
  name  = "asg_instance_profile"
  roles = ["${aws_iam_role.asg_instance_profile.name}"]
}

resource "aws_iam_role" "bastion_instance_profile" {
  name               = "bastion_instance_profile_role"
  path               = "/"
  assume_role_policy = "${file("${path.module}/data/policies/ec2_assume_role.json")}"
}

resource "aws_iam_instance_profile" "bastion" {
  name  = "bastion_instance_profile"
  roles = ["${aws_iam_role.bastion_instance_profile.name}"]
}

resource "aws_iam_role_policy" "bastion_role" {
  name   = "bastion_role_policy"
  role   = "${aws_iam_role.bastion_instance_profile.id}"
  policy = "${file("${path.module}/data/policies/bastion_role.json")}"
}

resource "template_file" "puppet_secrets_policy" {
  template = "${file("${path.module}/data/policies/puppet_secrets_bucket.json.tpl")}"

  vars {
    puppet_bucket      = "${var.puppet_bucket}"
    secrets_key_prefix = "${var.secrets_key_prefix}"
  }
}

resource "aws_iam_policy" "ec2_api_read" {
  name        = "ec2_api_read_access"
  path        = "/"
  description = "Policy to allow EC2 instances read access to the EC2 API"
  policy      = "${file("${path.module}/data/policies/ec2_api_read.json")}"
}

resource "aws_iam_policy_attachment" "ec2_api_read" {
  name = "ec2_api_read_policy_attachment"

  roles = [
    "${aws_iam_role.asg_instance_profile.name}",
    "${aws_iam_role.bastion_instance_profile.name}",
  ]

  policy_arn = "${aws_iam_policy.ec2_api_read.arn}"
}

resource "aws_iam_policy" "puppet_secrets" {
  name        = "puppet_secrets_bucket_access"
  path        = "/"
  description = "Policy to allow EC2 instances access to Puppet Secrets S3 bucket/path"
  policy      = "${template_file.puppet_secrets_policy.rendered}"
}

resource "aws_iam_policy_attachment" "puppet_secrets" {
  name = "puppet_secrets_policy_attachment"

  roles = [
    "${aws_iam_role.asg_instance_profile.name}",
    "${aws_iam_role.bastion_instance_profile.name}",
  ]

  policy_arn = "${aws_iam_policy.puppet_secrets.arn}"
}
