##
## Create a key pair
##  See: https://www.terraform.io/docs/providers/aws/r/key_pair.html

resource "aws_key_pair" "keypair_name" {

  # The name is set in the tfvar file
  key_name = "${var.keypair_name}"

  # The contents of the key will be read out of the file path stored in the
  # tfvar file.
  public_key = "${file(var.keypair_file)}"
}
