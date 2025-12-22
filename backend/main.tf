resource "aws_s3_bucket" "backend" {
  bucket        = "infra-state-file-bucket"
  region        = "us-east-1"
  force_destroy = true
  tags = {
    Purpose     = "Learning"
    Environment = "Dev"
  }
}


resource "aws_s3_bucket_versioning" "backend_versioning" {
  bucket = aws_s3_bucket.backend.id
  versioning_configuration {
    status = "Enabled"
  }
}
