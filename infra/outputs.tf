output "ecr_repo_url" {
  description = "URL of the created ECR repository"
  value       = aws_ecr_repository.app.repository_url
}

output "alb_dns_name" {
  value = aws_lb.app_alb.dns_name
}
