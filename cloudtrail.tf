data "aws_caller_identity" "current" {}
  
data "template_file" "cloudtrial_policy" {
  template = file("${path.module}/policy.json")
}

resource "aws_cloudtrail" "foobar" {
  name                          = "devenescloud"
  s3_bucket_name                = aws_s3_bucket.s3devenes.id
  s3_key_prefix                 = "prefix"
  include_global_service_events = false
}

resource "aws_s3_bucket_policy" "trail_policy" {
  bucket = aws_s3_bucket.s3devenes.id
  policy = data.template_file.cloudtrial_policy.rendered
}

resource "aws_s3_bucket" "s3devenes" {
  bucket        = "devenescloudbucket"
  force_destroy = true
}