# Resouruce Block: Random String
resource "random_string" "suffix" {
  length = 6
  special = false
  upper = false
}

# Resource Block: AWS S3 Bucket
resource "aws_s3_bucket" "demo_bucket" {
  bucket = "gordydev-${random_string.suffix.result}"

  tags = {
    Name        = "gordy bucket"
    Environment = "dev"
  }
}