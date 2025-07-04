# resource "aws_cloudfront_vpc_origin" "ec2e" {
#   vpc_origin_endpoint_config {
#     name                   = "portfolio"
#     arn                    = aws_instance.instance.arn
#     http_port              = 80
#     https_port             = 443
#     origin_protocol_policy = "http-only"

#     origin_ssl_protocols {
#       items    = ["TLSv1.2"]
#       quantity = 1
#     }
#   }
# }


# resource "aws_cloudfront_distribution" "vpc_origin_distribution" {
#   enabled          = true
#   retain_on_delete = false

#   origin {
#     vpc_origin_config {
#       vpc_origin_id = aws_cloudfront_vpc_origin.ec2e.id
#     }
#     domain_name = aws_instance.instance.private_dns
#     origin_id   = aws_cloudfront_vpc_origin.ec2e.id
#   }

#   default_cache_behavior {
#     allowed_methods  = ["GET", "HEAD"]
#     cached_methods   = ["GET", "HEAD"]
#     target_origin_id = aws_cloudfront_vpc_origin.ec2e.id
#     forwarded_values {
#       query_string = false

#       cookies {
#         forward = "none"
#       }
#     }
#     viewer_protocol_policy = "allow-all"
#     min_ttl                = 0
#     default_ttl            = 3600
#     max_ttl                = 86400
#   }

#   price_class = "PriceClass_All"

#   restrictions {
#     geo_restriction {
#       restriction_type = "none"
#       locations        = []
#     }
#   }

#   viewer_certificate {
#     cloudfront_default_certificate = true
#   }



# }
