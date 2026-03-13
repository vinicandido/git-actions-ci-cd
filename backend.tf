terraform {
  backend "s3" {
    bucket = "vini-candido-lab-29"
    key    = "site/backend.tfstate"
    region = "us-east-2"
  }
}
