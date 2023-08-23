resource "aws_s3_bucket" "bucket1" {
  bucket = "${var.prefix}-bucket1"  # Update with your desired bucket name
  acl    = "private"
}

resource "aws_s3_bucket_policy" "bucket1_policy" {
  bucket = aws_s3_bucket.bucket1.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid = "PublicRead",
        Effect = "Allow",
        Principal = "*",
        Action = ["s3:GetObject"],
        Resource = "${aws_s3_bucket.bucket1.arn}/*"
      }
    ]
  })
}

resource "aws_s3_bucket" "bucket2" {
  bucket = "${var.prefix}-bucket2"  # Update with your desired bucket name
  acl    = "private"
}

resource "aws_s3_bucket_policy" "bucket2_policy" {
  bucket = aws_s3_bucket.bucket2.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid = "PublicRead",
        Effect = "Allow",
        Principal = "*",
        Action = ["s3:GetObject"],
        Resource = "${aws_s3_bucket.bucket2.arn}/*"
      }
    ]
  })
}

resource "aws_s3_bucket" "bucket3" {
  bucket = "${var.prefix}-bucket3"  # Update with your desired bucket name
  acl    = "private"
}

resource "aws_s3_bucket_policy" "bucket3_policy" {
  bucket = aws_s3_bucket.bucket3.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid = "PublicRead",
        Effect = "Allow",
        Principal = "*",
        Action = ["s3:GetObject"],
        Resource = "${aws_s3_bucket.bucket3.arn}/*"
      }
    ]
  })
}