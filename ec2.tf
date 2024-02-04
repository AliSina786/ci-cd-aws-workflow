data "aws_ami" "ubuntu" {
  most_recent = true


  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "Webserver" {
  subnet_id       = aws_subnet.public_subnet.id
  ami             = data.aws_ami.ubuntu.id
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.sg.id]
  key_name        = "WebServer"

  user_data = <<EOF
#!/bin/bash
sudo apt update -y
sudo apt-get install apache2 -y
sudo systemctl start apache2
sudo bash -c 'echo "Defining a Complete CI/CD Workflow to Build and Operate Applications on AWS" > /var/www/html/index.html'

EOF

  tags = {
    Name = "Webserver"
  }
}

output "public_ip" {
  value = aws_instance.Webserver.public_ip
}