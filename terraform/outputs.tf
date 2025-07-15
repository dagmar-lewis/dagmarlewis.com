output "cloudfront_url" {
  value = aws_cloudfront_distribution.vpc_origin_distribution.domain_name
}


output "ec2id" {
  value = aws_instance.instance.id
}