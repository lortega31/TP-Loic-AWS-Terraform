# backend.tf
terraform {
  backend "s3" {
    bucket         = "tploic"
    key            = "tfstate/tploic.tfstate"
    region         = "eu-west-3"
	}
}	