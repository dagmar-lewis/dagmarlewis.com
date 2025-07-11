resource "aws_cloudfront_vpc_origin" "ec2e" {
  vpc_origin_endpoint_config {
    name                   = "portfolio"
    arn                    = aws_instance.instance.arn
    http_port              = 80
    https_port             = 443
    origin_protocol_policy = "http-only"

    origin_ssl_protocols {
      items    = ["TLSv1.2"]
      quantity = 1
    }
  }
}


resource "aws_cloudfront_distribution" "vpc_origin_distribution" {
  enabled          = true
  retain_on_delete = false

  origin {
    vpc_origin_config {
      vpc_origin_id = aws_cloudfront_vpc_origin.ec2e.id
    }
    domain_name = aws_instance.instance.private_dns
    origin_id   = aws_cloudfront_vpc_origin.ec2e.id
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_cloudfront_vpc_origin.ec2e.id
    cache_policy_id = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad" # cache policy managed disable
    origin_request_policy_id = "216adef6-5c7f-47e4-b989-5492eafa07d3" # managed all viewer
    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
  }



  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }



}
