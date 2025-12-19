terraform {
  backend "s3" {
    bucket = "infra-state-file-bucket"
    region = "us-east-1"
  }
}
