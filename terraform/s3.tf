resource "random_id" "random" {
  byte_length = 4
}

resource "aws_s3_bucket" "private_bucket" {
  bucket        = "my-bucket-${random_id.random.hex}"
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "app" {
  bucket                  = aws_s3_bucket.private_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}