terraform {
  backend "s3" {
    bucket = "infra-state-file-bucket"
    key    = "terrafom-state/state"
    region = "us-east-1"
  }
}
