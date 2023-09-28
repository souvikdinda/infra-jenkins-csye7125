# #DNS Route 53

resource "aws_route53_record" "jenkins_dns" {
  name    = "jenkins.${var.host_name}"
  type    = "A"
  zone_id = data.aws_route53_zone.zone_name.id
  ttl     = "60"
  records = [data.aws_eip.elastic_ip.public_ip]
}

