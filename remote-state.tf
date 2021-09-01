terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "samaritano"

    workspaces {
      name = "aws-terraform"
    }
  }
}