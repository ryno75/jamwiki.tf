resource "aws_route53_record" "wiki" {
  zone_id = "/hostedzone/${var.hosted_zone_id}"
  name    = "${var.domain_name}"
  type    = "CNAME"
  ttl     = "300"
  records = ["${module.wiki_elb.elb_dns_name}"]
}
