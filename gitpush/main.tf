provider "aws" {
  region = "ap-south-1"
  profile = "Akarsh"
}
module "ec2" {
    source = "./ec2"
    route_table = "${module.routetable.Route}"
    subnet_id = "${module.subnet.subnet1}"
    security_g = "${module.securitygroup.sgdata1}"
    security_g_wordpress = "${module.securitygroup.sgword2}"
    subnet2id = "${module.subnet.subnet2}"
    key = "${module.key.Key}"
}
module "internetgw" {
    source = "./internetgw"
    vpcmain = "${module.vpc.vpc1}"
    vpcmainid = "${module.vpc.vpc2}"
    
}
module "key" {
    source = "./key"
    
}
module "routetable" {
    source = "./routetable"
    ig1 = "${module.internetgw.MY_Internet_Gateway}"
    ig2 = "${module.internetgw.MY_Internet_Gateway_ID}"
    vpcid = "${module.vpc.vpc2}"
    subnetid = "${module.subnet.subnet2}"
 
}
module "securitygroup" {
    source = "./sg"
    vpc1 = "${module.vpc.vpc1}"
    vpc2 = "${module.vpc.vpc2}"
    
}
module "subnet" {
    source = "./subnet"
    vpc1 = "${module.vpc.vpc1}"
    vpc2 = "${module.vpc.vpc2}"
    
}
module "vpc" {
    source = "./vpc"
    
}