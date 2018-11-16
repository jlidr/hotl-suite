
# See:
#  https://www.terraform.io/docs/modules/
#  https://github.com/TheWeatherCompany/grid-env-modules

# ref=VAL can be used to specify a tagged release to use from the grid-env-modules repo.
# example:
#   source = "git::ssh://git@github.com/TheWeatherCompany/grid-env-modules.git//terraform/common-ami?ref=v0.1.9"
# Would reference the tag v0.1.9
#
# It would be nice to set the tag via a terraform variable, but
# this isn't supported yet.
# See https://github.com/hashicorp/terraform/issues/1439#issuecomment-93838774

##
## module for common ami types across regions
##

module "common-ami" {
  source = "git::ssh://git@github.com/TheWeatherCompany/grid-env-modules.git//terraform/common-ami"
  region = "${var.region}"
}

##
## module for common ips; office and grid_gem_external_ips for gem ssh automation
##

module "common-vpc" {
  source = "git::ssh://git@github.com/TheWeatherCompany/grid-env-modules.git//terraform/common-vpc"
}
