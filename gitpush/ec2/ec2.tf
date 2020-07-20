resource "aws_instance"  "database" {
  depends_on = [
    "var.route_table"
  ]
  ami = "ami-0b75cad5b6a829203"
  instance_type = "t2.micro"
  subnet_id = "var.subnet_id"
  vpc_security_group_ids = ["var.security_g"]
  key_name = "webserver"
  user_data = <<-EOF
        #!/bin/bash
        sudo docker run -dit -p 8888:3306 --name mysql -e MYSQL_ROOT_PASSWORD=rootpass -e MYSQL_DATABASE=mydb -e MYSQL_USER=Akarsh -e MYSQL_PASSWORD=redhat mysql:5.6
  
  EOF
}

output "database" {
       value = "${aws_instance.database}"
}

output "databaseprivateip" {
       value = "${aws_instance.database.private_ip}"
}

//---------------------------------------------------------------------------------------------------

resource "aws_instance" "wordpress" {
  depends_on = [
    aws_instance.database
  ]
  ami           = "ami-0b75cad5b6a829203"
  instance_type = "t2.micro"
  key_name       = "webserver"
  vpc_security_group_ids = [ "var.security_g_wordpress" ]
  subnet_id = "var.subnet2id"


  connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = "var.key"
    host     = aws_instance.wordpress.public_ip
  }


  provisioner "remote-exec" {
    inline = [
      "sudo su << EOF",
      "sudo docker run -dit -e WORDPRESS_DB_HOST=${aws_instance.database.private_ip}:8888 -e WORDPRESS_DB_USER=Akarsh -e WORDPRESS_DB_PASSWORD=redhat -e WORDPRESS_DB_NAME=mydb -p 80:80 --name wp wordpress:4.8-apache",
      "sudo sleep 120",
      "sudo docker start wp"
    ]
}
}

output "wordpressinstancepublicip" {
       value = "${aws_instance.wordpress.public_ip}"
}