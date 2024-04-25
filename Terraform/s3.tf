
resource "aws_s3_bucket" "wp_media" {
  bucket = "wordpress-media-${random_id.bucket_suffix.hex}"

  tags = {
    Name = "WordPress Storage"
  }
}

resource "random_id" "bucket_suffix" {
  byte_length = 4
}