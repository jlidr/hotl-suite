# consider using terraform overrides to override these aws variables with a
# file called secrets_override.tf (auto listed in your git ignore)
#
# https://www.terraform.io/docs/configuration/override.html

##
## Configure AWS provider (aws account to create objects in)
##  See: https://www.terraform.io/docs/providers/aws/index.html
##
## If you need to reference objects in multiple accounts, see the `alias`
## construct for providers:
##  https://terraform.io/docs/configuration/providers.html
##  `Multiple Provider Instances`
##

provider "aws" {
  access_key = "${var.project_aws_access_key}"
  secret_key = "${var.project_aws_secret_key}"

  region = "${var.region}"
}
