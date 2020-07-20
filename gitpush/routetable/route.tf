resource "aws_route_table" "wordpress" {
  depends_on = [
    "var.ig1"
  ]
  vpc_id = "var.vpcid"
   route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "var.ig2"
  }
  tags = {
    Name = "MyrouteTable"
  }
}

output "Routetable" {
       value = "${aws_route_table.wordpress.id}"
}

output "Route" {
       value = "${aws_route_table.wordpress}"
}

resource "aws_route_table_association" "a" {
  subnet_id      = "var.subnetid"
  route_table_id = aws_route_table.wordpress.id
}