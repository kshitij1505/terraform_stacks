resource "aws_s3_bucket" "my_bucket" {
  bucket_prefix = "backend-bucket"
  tags = {
    Name        = "My bucket"
    Environment = "Sandbox"
  }
}