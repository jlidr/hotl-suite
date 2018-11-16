
##
## Define skybase_core
##  See: https://www.terraform.io/docs/providers/aws/r/instance.html
##

resource "aws_instance" "skybase_core_stack_1" {

  ami = "${var.skybase_core_ami}"
  instance_type = "${var.skybase_core_instance_type}"

  subnet_id = "${element(aws_subnet.public.*.id, 0)}"
  vpc_security_group_ids = [  "${aws_security_group.sg_vpc_all.id}",
                              "${aws_security_group.sg_admin.id}"  ]

  key_name = "${var.keypair_name}"

  associate_public_ip_address = true

  iam_instance_profile = "${aws_iam_instance_profile.stack_1_profile.name}"
  private_ip = "${var.skybase_core_stack_1_ip}"

  user_data = <<HERE
#!/bin/bash -ex

/sbin/service pacemaker stop
/sbin/chkconfig pacemaker off

rpm -ivh http://external-repo.grid.weather.com/6/s3get-1.0.2-1_gridspin.x86_64.rpm
#/usr/local/bin/s3get -region="${var.region}" s3://${aws_s3_bucket.stack_1_s3_bucket.id}/Bad_COD_North_Pole.png > /tmp/testimage.png
#/usr/local/bin/s3get -region="${var.region}" s3://${aws_s3_bucket.stack_1_s3_bucket.id}/somefile | tee /tmp/somefile
HERE

  tags {
    Name = "${var.project}-skybase_core-stack-1"
  }
}

##
## Define max_core
##  See: https://www.terraform.io/docs/providers/aws/r/instance.html
##

resource "aws_instance" "max_core_stack_1" {

  ami = "${var.max_core_ami}"
  instance_type = "${var.max_core_instance_type}"

  subnet_id = "${element(aws_subnet.public.*.id, 0)}"
  vpc_security_group_ids = [  "${aws_security_group.sg_vpc_all.id}",
                              "${aws_security_group.sg_admin.id}",
                              "${aws_security_group.sg_edit_server.id}",
                              "${aws_security_group.sg_data_server.id}"  ]

  key_name = "${var.keypair_name}"

  associate_public_ip_address = true

  iam_instance_profile = "${aws_iam_instance_profile.stack_1_profile.name}"
  private_ip = "${var.max_core_stack_1_ip}"
//   user_data = <<HERE
// #!/bin/bash -ex
//
// rpm -ivh http://external-repo.grid.weather.com/6/s3get-1.0.2-1_gridspin.x86_64.rpm
// /usr/local/bin/s3get -region="${var.region}" s3://${aws_s3_bucket.stack_1_s3_bucket.id}/Bad_COD_North_Pole.png > /tmp/testimage.png
// #/usr/local/bin/s3get -region="${var.region}" s3://${aws_s3_bucket.stack_1_s3_bucket.id}/somefile | tee /tmp/somefile
// HERE

  tags {
    # See count explaination in nat instance.
    Name = "${var.project}-max_core-stack-1"
  }
}


##
## output
##

output "stack_1_output" {
  value = <<HERE

  Stack 1
    skybase_core: ${aws_instance.skybase_core_stack_1.id}
      public: ${aws_instance.skybase_core_stack_1.public_ip}
      private: ${aws_instance.skybase_core_stack_1.private_ip}
    max_core: ${aws_instance.max_core_stack_1.id}
      public: ${aws_instance.max_core_stack_1.public_ip}
      private: ${aws_instance.max_core_stack_1.private_ip}
HERE

}
