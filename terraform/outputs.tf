output "repository_url" {
  value = aws_ecr_repository.portfolio_container_image.repository_url
}

output "instance_public_ip" {
  value = aws_instance.instance.public_ip
}