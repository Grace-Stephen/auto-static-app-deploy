terraform {
  backend "s3" {
    bucket         = "gracestephen-terraform-backend"
    key            = "ha-infra/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tfstate-lock"
    encrypt        = true
  }
}
