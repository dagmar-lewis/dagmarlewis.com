resource "aws_ecr_repository" "portfolio_container_image" {
  name                 = "portfolio"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
