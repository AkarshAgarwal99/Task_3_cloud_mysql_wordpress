resource "aws_subnet" "main1" {
  depends_on = [
    "var.vpc1"
  ]
  vpc_id     = "var.vpc2"
  cidr_block = "192.168.0.0/24"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "mysqlsubnet"
  }
}

output "subnet1" {
       value = "${aws_subnet.main1.id}"
}

resource "aws_subnet" "main2" {
  depends_on = [
    "var.vpc1"
  ]
  vpc_id     = "var.vpc2"
  cidr_block = "192.168.1.0/24"
  availability_zone = "ap-south-1b"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "wordpresssubnet"
  }
}

output "subnet2" {
       value = "${aws_subnet.main2.id}"
}