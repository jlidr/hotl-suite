##
## Define VPC
##  See: https://www.terraform.io/docs/providers/aws/r/vpc.html

resource "aws_vpc" "main" {
  cidr_block = "${var.vpc_cidr_block}"

  tags {
    Name = "vpc-${var.project}-${var.region}"
  }
}

output "VPC id" {
  value = "${aws_vpc.main.id}"
}

##
## Define internet gateway - Links VPC with the internet
##  See: https://www.terraform.io/docs/providers/aws/r/internet_gateway.html

resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "igw-${var.project}-${var.region}"
  }
}

##
## Define public subnet
##  See: https://www.terraform.io/docs/providers/aws/r/subnet.html

resource "aws_subnet" "public" {
  count = "${var.az_count}"

  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${element(split(",",var.public_cidr_blocks),count.index)}"

  availability_zone = "${var.region}${element(split(",",var.zones), count.index)}"
  map_public_ip_on_launch = false

  tags {
    Name = "sn-${var.project}-${var.region}-public-${element(split(",",var.zones),count.index)}"
  }
}

##
## Define public route table - how to route traffic to the igw
##  See: https://www.terraform.io/docs/providers/aws/r/route_table.html

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main.id}"
  }

  tags {
    Name = "rtb-${var.project}-${var.region}-main"
  }
}

##
## Associate Route Table with public subnet - Link the subnet and the route table
##  See: https://www.terraform.io/docs/providers/aws/r/route_table_association.html

resource "aws_route_table_association" "public" {
  count = "${var.az_count}"

  route_table_id = "${aws_route_table.public.id}"
  subnet_id = "${element(aws_subnet.public.*.id, count.index)}"
  #count = "${length(split(",", var.public_cidr_blocks))}"
}
