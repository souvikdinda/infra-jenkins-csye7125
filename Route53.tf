# #DNS Route 53

# resource "aws_route53_record" "jenkins_dns" {
#   name    = var.zone_name
#   type    = "A"
#   zone_id = var.zone_id  
#   ttl     = "60"
#   records = [aws_eip.elastic_ip.public_ip]
# }

