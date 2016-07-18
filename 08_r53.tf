resource "aws_route53_record" "wikidb" {
  zone_id = "/hostedzone/${var.hosted_zone_id}"
  name    = "${var.database_fqdn}"
  type    = "CNAME"
  ttl     = "300"
  records = ["${module.jwdb_rds.rds_instance_address}"]
}

resource "aws_route53_record" "wiki" {
  zone_id = "/hostedzone/${var.hosted_zone_id}"
  name    = "${var.wiki_fqdn}"
  type    = "CNAME"
  ttl     = "300"
  records = ["${module.wiki_elb.elb_dns_name}"]
}

resource "aws_route53_record" "bastion" {
  zone_id = "/hostedzone/${var.hosted_zone_id}"
  name    = "${var.bastion_fqdn}"
  type    = "A"
  ttl     = "14400"
  records = ["${module.bastion.public_ip}"]
}
