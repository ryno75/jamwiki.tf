resource "aws_iam_instance_profile" "asg_instance_profile" {
  name = "asg_instance_profile"
  roles = ["${aws_iam_role.asg_instance_role.name}"]
}

resource "aws_iam_role" "asg_instance_role" {
  name = "asg_instance_profile_role"
  path = "/"
  assume_role_policy = "${file("${path.module}/data/policies/ec2_assume_role.json")}"
}

