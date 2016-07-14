resource "aws_key_pair" "keypair" {
  key_name   = "${var.key_name}"
  public_key = "${file("${path.module}/data/${var.key_name}.pub")}"
}
