# resource "aws_route53_zone" "primary" {
#   name = "dagmarlewis.com"
# }

# resource "aws_route53_record" "main" {
#   zone_id = aws_route53_zone.primary.zone_id
#   name    = "dagmarlewis.com"
#   type    = "A"
#   ttl     = 300
#   records = [aws_instance.instance.public_ip]
# }