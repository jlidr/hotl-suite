##
## stack_2 IAM policy - define allowed actions
##   See: https://www.terraform.io/docs/providers/aws/r/iam_policy.html

resource "aws_iam_policy" "stack_2_policy" {
  name = "${var.project}-${var.tier}-${var.region}-stack_2_policy"
  path = "/"
  description = "${var.project}-${var.tier}-${var.region}-stack_2_policy"
  policy =<<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "ec2:Describe*"
            ],
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "${aws_s3_bucket.stack_2_s3_bucket.arn}",
                "${aws_s3_bucket.stack_2_s3_bucket.arn}/*"
            ]
        }
    ]
}
EOF
}

##
## stack_2 IAM role - an instance can take on a role, this allows a role
## to link with an iam policy.
##   See: https://www.terraform.io/docs/providers/aws/r/iam_role.html

resource "aws_iam_role" "stack_2_role" {

  name = "${var.project}-${var.tier}-${var.region}-stack_2_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

##
## stack_2 IAM policy attachment - attach the iam policy to the role.
##   See: https://www.terraform.io/docs/providers/aws/r/iam_policy_attachment.html

resource "aws_iam_policy_attachment" "stack_2_policy-attach" {
  name = "${var.project}-${var.tier}-${var.region}-stack_2_policy-attach"
  roles = ["${aws_iam_role.stack_2_role.name}"]
  policy_arn = "${aws_iam_policy.stack_2_policy.arn}"
}

##
## stack_2 IAM role - an instance can be launched with a profile, which indicates
## that which role inherit.
##   See: https://www.terraform.io/docs/providers/aws/r/iam_instance_profile.html

resource "aws_iam_instance_profile" "stack_2_profile" {
  name = "${var.project}-${var.tier}-${var.region}-stack_2_profile"
  roles = ["${aws_iam_role.stack_2_role.name}"]
}
