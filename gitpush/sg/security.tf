resource "aws_security_group" "allow_tls1" {
  depends_on = [
    "var.vpc1"
  ]
  name        = "mywordpresssecurity"
  description = "Allow inbound traffic"
  vpc_id      = "var.vpc2"

  ingress {
    description = "mysecurity"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  ingress {
    description = "mysecurity"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Mywordpress"
  }
}

output "sgword1" {
       value = "${aws_security_group.allow_tls1}"
}

output "sgword2" {
       value = "${aws_security_group.allow_tls1.id}"
}

//---------------------------------------------------------------------------------------------------
resource "aws_security_group" "allow_tls2" {
  depends_on = [
    aws_security_group.allow_tls1
  ]
  name        = "mysql_security_group"
  description = "Allow_only_wordpress_traffic"
  vpc_id      = "var.vpc2"

  ingress {
   from_port = 3306
   to_port = 3306
   protocol = "tcp"
   security_groups = ["${aws_security_group.allow_tls1.id}"]
  }
  
  ingress {
   from_port = 8888
   to_port = 8888
   protocol = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
   from_port = 0
   to_port = 0
   protocol = "-1"
   security_groups = ["${aws_security_group.allow_tls1.id}"]
  }
}

output "sgdata1" {
       value = "${aws_security_group.allow_tls2.id}"
}