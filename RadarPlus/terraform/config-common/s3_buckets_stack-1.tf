##
## Define S3 buckets
##  See: https://www.terraform.io/docs/providers/aws/r/s3_bucket.html
##  Note: Non-empty buckets will not be destoyed by default. Force destroy
##        with force_destroy = true

##
## stack_1_s3_bucket bucket
##

resource "aws_s3_bucket" "stack_1_s3_bucket" {
  bucket = "${var.project}-${var.tier}-${var.region}-stack-1"
  acl = "private"

  force_destroy = false

  # keep all copies of every file added to this bucket.
  versioning {
    enabled = true
  }

  tags {
      Name = "${var.project}-${var.tier}-${var.region}-stack-1"
      Environment = "${var.tier}"
  }
}

output "stack_1_s3_bucket" {
    value = "${aws_s3_bucket.stack_1_s3_bucket.id}"
}
