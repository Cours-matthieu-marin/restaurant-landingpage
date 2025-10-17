variable "site_bucket_name" {
  description = "Nom du bucket S3 pour le site statique"
  type        = string
  default     = "my-restaurant-site-ccm-6277351256"
}

resource "aws_s3_bucket" "site" {
  bucket = var.site_bucket_name
  tags   = { Project = "restaurant-static-site" }
}

resource "aws_s3_bucket_website_configuration" "site" {
  bucket = aws_s3_bucket.site.id

  index_document { suffix = "index.html" }
  error_document { key    = "404.html" }
}

resource "aws_s3_bucket_public_access_block" "site" {
  bucket                  = aws_s3_bucket.site.id
  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_ownership_controls" "site" {
  bucket = aws_s3_bucket.site.id
  rule { object_ownership = "BucketOwnerEnforced" }
}

data "aws_iam_policy_document" "public_read" {
  statement {
    sid     = "PublicReadGetObject"
    effect  = "Allow"
    actions = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.site.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}

resource "aws_s3_bucket_policy" "site" {
  bucket = aws_s3_bucket.site.id
  policy = data.aws_iam_policy_document.public_read.json
}

output "website_endpoint" {
  value       = "http://${aws_s3_bucket.site.bucket}.s3-website-${data.aws_region.current.name}.amazonaws.com"
  description = "URL publique du site statique"
}

data "aws_region" "current" {}