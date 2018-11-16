## Securtity groups for all instances

##
## sg_admin - security group
##  See: https://www.terraform.io/docs/providers/aws/r/security_group.html

resource "aws_security_group" "sg_admin" {
  name = "sg_admin"
  description = "sg_admin"

  vpc_id = "${aws_vpc.main.id}"
}

##
## rules for sg_admin  security group
##
## Add a rule for each ip block offered by common-vpc/twc_cidr_blocks_offices
## to security group called sg_admin see:
##                        https://github.com/TheWeatherCompany/grid-env-modules
##
##  See: https://www.terraform.io/docs/providers/aws/r/security_group_rule.html

resource "aws_security_group_rule" "sg_admin_ingress_22_offices" {
  type = "ingress"
  # SSH access is over port 22
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["${split(",",module.common-vpc.twc_cidr_blocks_offices)}","10.142.0.0/16"]
#  10.142.0.0/16
  security_group_id = "${aws_security_group.sg_admin.id}"
}

resource "aws_security_group_rule" "sg_admin_ingress_RDP_offices" {
  type = "ingress"
  # Remote Desktop Process communicates via port 3389
  from_port = 3389
  to_port = 3389
  protocol = "tcp"
  cidr_blocks = ["${split(",",module.common-vpc.twc_cidr_blocks_offices)}","10.142.0.0/16"]
#  10.142.0.0/16
  security_group_id = "${aws_security_group.sg_admin.id}"
}

resource "aws_security_group_rule" "sg_admin_ingress_HOTL_clients" {
  type = "ingress"
  # HOTL clients communicate with HOTL server via port 7779
  from_port = 7779
  to_port = 7779
  protocol = "tcp"
  cidr_blocks = ["${split(",",module.common-vpc.twc_cidr_blocks_offices)}","10.142.0.0/16"]
#  10.142.0.0/16
  security_group_id = "${aws_security_group.sg_admin.id}"
}

resource "aws_security_group_rule" "sg_admin_egress_all" {
  type = "egress"
  # Outgoing access over any port
  from_port = 0
  to_port = 0
  # Access using any protocol
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.sg_admin.id}"
}

##
## rules for sg_vpc_all  security group
##
## Allow all systems in this security group to talk to all other systems on all
## Ports
##
##  See: https://www.terraform.io/docs/providers/aws/r/security_group_rule.html

resource "aws_security_group" "sg_vpc_all" {
  name = "sg_vpc_all"
  description = "sg_vpc_all"

  vpc_id = "${aws_vpc.main.id}"
}

resource "aws_security_group_rule" "sg_vpc_all_ingress_all" {
  type = "ingress"
  # Incomming access from any port
  from_port = 0
  to_port = 0
  # Access via any protocol
  protocol = "-1"

  security_group_id = "${aws_security_group.sg_vpc_all.id}"
  # Restrict this open access to members of this security group
  self = true
}

resource "aws_security_group_rule" "sg_vpc_all_egress_all" {
  type = "egress"
  # Outgoing access over any port
  from_port = 0
  to_port = 0
  # Access using any protocol
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.sg_vpc_all.id}"
}
##
## rules for sg_admin  security group
##
resource "aws_security_group" "sg_edit_server" {
  name = "sg_edit_server"
  description = "sg_edit_server"

  vpc_id = "${aws_vpc.main.id}"
}

resource "aws_security_group_rule" "sg_edit_server_udp_ports" {
  type = "ingress"
  # UDP uses ports 5404 and 5405
  from_port = 5404
  to_port = 5405
  protocol = "udp"
  cidr_blocks = ["${split(",",module.common-vpc.twc_cidr_blocks_offices)}"]
#  10.233.243.0/24
  security_group_id = "${aws_security_group.sg_edit_server.id}"
}

resource "aws_security_group_rule" "sg_edit_server_https_ports" {
  type = "ingress"
  # HTTPS uses port 443
  from_port = 443
  to_port = 443
  protocol = "tcp"
  cidr_blocks = ["${split(",",module.common-vpc.twc_cidr_blocks_offices)}","64.25.21.13/32","64.25.21.14/32","64.25.21.15/32","64.25.22.13/32","64.25.22.14/32","64.25.22.15/32","64.25.25.249/32","64.25.29.249/32","104.129.196.126/32"]

  // #  64.25.21. 13,14,15 /32
  // #  64.25.22. 13,14,15 /32
  // #  64.25.25.249/32
  // #  64.25.29.249/32
  // # 104.129.196.126/32
  security_group_id = "${aws_security_group.sg_edit_server.id}"
}

resource "aws_security_group_rule" "sg_edit_server_egress_all" {
  type = "egress"
  # Outgoing access over any port
  from_port = 0
  to_port = 0
  # Access using any protocol
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.sg_edit_server.id}"
}

##
## rules for sg_data_server security group
##
resource "aws_security_group" "sg_data_server" {
  name = "sg_data_server"
  description = "sg_data_server"

  vpc_id = "${aws_vpc.main.id}"
}

resource "aws_security_group_rule" "sg_admin_ingress_ldm_ports" {
  type = "ingress"
  # LDM uses port 388
  from_port = 388
  to_port = 388
  protocol = "udp"
  cidr_blocks = ["${split(",",module.common-vpc.twc_cidr_blocks_offices)}","10.142.0.0/16"]
  // #  96.8.92.0/24
  // #  96.8.93.0/24
  // #  96.8.94.0/24
  // #  10.142.0.0/16
  security_group_id = "${aws_security_group.sg_data_server.id}"
}

resource "aws_security_group_rule" "sg_data_server_TCP_ports" {
  type = "ingress"
  # tcp uses port 2224
  from_port = 2224
  to_port = 2224
  protocol = "tcp"
  cidr_blocks = ["${split(",",module.common-vpc.twc_cidr_blocks_offices)}","10.142.0.0/16"]
  // #  10.142.0.0/16
  security_group_id = "${aws_security_group.sg_data_server.id}"
}

resource "aws_security_group_rule" "sg_data_server_postgres_ports" {
  type = "ingress"
  # Postgres uses port 5432
  from_port = 5432
  to_port = 5432
  protocol = "tcp"
  cidr_blocks = ["${split(",",module.common-vpc.twc_cidr_blocks_offices)}","10.142.0.0/16"]
  // #  10.142.0.0/16
  security_group_id = "${aws_security_group.sg_data_server.id}"
}

resource "aws_security_group_rule" "sg_data_server_egress_all" {
  type = "egress"
  # Outgoing access over any port
  from_port = 0
  to_port = 0
  # Access using any protocol
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.sg_data_server.id}"

}
