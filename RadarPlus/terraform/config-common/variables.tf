##
## Define variables. Variables are set in the tfvars file in each deploy dir
##  See: https://terraform.io/docs/configuration/variables.html


## Name of the project you are working on. Will be used in many tag and names.
## Changing this may cause things like security groups to be re-created because
## some objects cannot be renamed.
variable "project" {}

## Normally dev/qa/staging/prod. Will be used in many tags and names.
variable "tier" {}

## Which region to send api calls to, and where to deploy to.
## This variable defaults to us-east-1 is it is not defined in tfvars.
variable "region" {
  default = "us-east-1"
}

## A single letter to append to region to identify an availablity zone.
variable "zones" {}

## The block of IPs for the VPC. Please open a ticket with NetOPs to get a
## VPC block (or blocks) assigned to this project.
variable "vpc_cidr_block" {}

## The block of IPs to use in the public subnets, comma deliminated.
variable "az_count" {}

## The block of IPs to use in the public subnets, comma deliminated.
variable "public_cidr_blocks" {}

## Name of the keypair to be created in aws. Note, if you already have a keypair
## you can delete the keypairs.tf file and keypair_file variable and reference a
## keypair you already imported.
variable "keypair_name" {}

## Path to a file you want to use as your public key.
variable "keypair_file" {}

## Do not fill these out, you should be using OS environment variables,
## a gemsecrets file, or an _override.tf file.
variable "project_aws_access_key" {}

## Do not fill these out, you should be using OS environment variables,
## a gemsecrets file, or an _override.tf file.
variable "project_aws_secret_key" {}

variable "radarplus_server_ami" {}
variable "radarplus_server_instance_type" {}

variable "radarplus_server_stack_1_ip" {}
variable "radarplus_server_stack_2_ip" {}
