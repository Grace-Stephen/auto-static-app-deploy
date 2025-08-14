resource "aws_instance" "app" {
  count                   = 2
  ami                     = var.ami
  instance_type           = var.instance_type
  subnet_id               = aws_subnet.private[count.index].id
  security_groups         = [aws_security_group.ec2_sg.id]
  iam_instance_profile    = aws_iam_instance_profile.ec2_ecr_profile.name

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y docker
              sudo service docker start
              sudo usermod -aG docker ec2-user
              aws ecr get-login-password --region ${var.region} | docker login --username AWS --password-stdin ${var.account_id}.dkr.ecr.${var.region}.amazonaws.com
              docker pull ${var.account_id}.dkr.ecr.${var.region}.amazonaws.com/${var.ecr_repo_name}:latest
              docker run -d -p 80:80 ${var.account_id}.dkr.ecr.${var.region}.amazonaws.com/${var.ecr_repo_name}:latest
              EOF

  tags = {
    Name = "AppServer-${count.index + 1}"
  }

  depends_on = [
    aws_ecr_repository.app
  ]
}
#