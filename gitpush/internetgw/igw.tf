resource "aws_internet_gateway" "gw" {
  depends_on = [
    "var.vpcmain"
  ]
  vpc_id = "var.vpcmainid"

  tags = {
    Name = "AkarshInternetGateway"
  }
}

output "MY_Internet_Gateway_ID" {
       value = "${aws_internet_gateway.gw.id}"
}

output "MY_Internet_Gateway" {
       value = "${aws_internet_gateway.gw}"
}