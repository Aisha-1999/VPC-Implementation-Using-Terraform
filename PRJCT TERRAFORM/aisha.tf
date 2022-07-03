provider "aws" {
  region = "ap-south-1"
}



resource "aws_instance" "aisha" {
  ami               = "ami-5b673c34"
  instance_type     = "t2.micro"
  availability_zone = "ap-south-1a"
  
  
    subnet_id = "${aws_subnet.prod-subnet-public-1.id}"
    
    vpc_security_group_ids = ["${aws_security_group.ssh-allowed.id}"]


  key_name = "aisha"
  user_data = <<-EOF
                #! /bin/bash
                sudo yum install httpd -y
                sudo systemctl start httpd
                sudo systemctl enable httpd
                echo "<h1>Sample Webserver Network AISHA" | sudo tee  /var/www/html/index.html
  EOF


  tags = {
        Name = "webserver"
  }

}
