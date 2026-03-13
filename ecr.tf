resource "aws_ecr_repository" "ecr_sis" {
  name                 = "ecr_sis"
  image_tag_mutability = "MUTABLE"
}