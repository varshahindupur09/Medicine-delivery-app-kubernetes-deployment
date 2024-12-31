resource "aws_ecr_repository" "backend_repo" {
  name = "medicine-backend"
}

resource "aws_ecr_repository" "frontend_repo" {
  name = "medicine-frontend"
}