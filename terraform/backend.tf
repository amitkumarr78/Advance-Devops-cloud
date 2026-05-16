terraform {
  backend "s3" {
    bucket         = "amit-devops-tf-state-4582"
    key            = "terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}