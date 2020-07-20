resource "aws_vpc" "main" {
  cidr_block       = "192.168.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "AkarshVPC"
  }
}

output "vpc1" {
       value = "${aws_vpc.main}"
}

output "vpc2" {
       value = "${aws_vpc.main.id}"
}