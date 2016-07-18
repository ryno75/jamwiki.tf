resource "aws_iam_role" "asg_instance_role" {
  name = "asg_instance_profile_role"
  path = "/"
  assume_role_policy = "${file("${path.module}/data/policies/ec2_assume_role.json")}"
}

resource "aws_iam_instance_profile" "asg_instance_profile" {
  name = "asg_instance_profile"
  roles = ["${aws_iam_role.asg_instance_role.name}"]
}

resource "aws_iam_role" "bastion_instance_profile_role" {
  name = "bastion_instance_profile_role"
  path = "/"
  assume_role_policy = "${file("${path.module}/data/policies/ec2_assume_role.json")}"
}

resource "aws_iam_instance_profile" "bastion_instance_profile" {
  name = "bastion_instance_profile"
  roles = ["${aws_iam_role.bastion_instance_profile_role.name}"]
}

resource "aws_iam_role_policy" "bastion_role_policy" {
  name = "bastion_role_policy"
  role = "${aws_iam_role.bastion_instance_profile_role.id}"
  policy = "${file("${path.module}/data/policies/bastion_role.json")}"
}
