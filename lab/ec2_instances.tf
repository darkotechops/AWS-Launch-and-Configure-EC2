provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "web_sg" {
  name        = "Security-Group-Lab"
  description = "HTTP Security Group"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_vpc" "test_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "subnet_a" {
  vpc_id            = aws_vpc.test_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "subnet_b" {
  vpc_id            = aws_vpc.test_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "webserver01" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet_a.id
  security_groups = [aws_security_group.web_sg.name]
  key_name      = null

  user_data = <<-EOF
              #!/bin/bash
              echo "<html><body><h1>Instance Information</h1><pre>" > /var/www/html/index.html
              curl http://169.254.169.254/latest/meta-data/ >> /var/www/html/index.html
              echo "</pre></body></html>" >> /var/www/html/index.html
              yum install -y httpd
              service httpd start
              EOF

  tags = {
    Name = "webserver01"
  }
}

resource "aws_instance" "webserver02" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet_b.id
  security_groups = [aws_security_group.web_sg.name]
  key_name      = null

  user_data = <<-EOF
              #!/bin/bash
              echo "<html><body><h1>Instance Information</h1><pre>" > /var/www/html/index.html
              curl http://000.000.000.000/latest/meta-data/ >> /var/www/html/index.html
              echo "</pre></body></html>" >> /var/www/html/index.html
              yum install -y httpd
              service httpd start
              EOF

  tags = {
    Name = "webserver02"
  }
}

output "webserver01_public_ip" {
  value = aws_instance.webserver01.public_ip
}

output "webserver02_public_ip" {
  value = aws_instance.webserver02.public_ip
}

/*
Key Components:
Security Group: This is configured to allow inbound HTTP traffic on port 80 from any source (0.0.0.0/0).
VPC and Subnets: A custom VPC is created with two subnets in different Availability Zones (us-east-1a for webserver01 and us-east-1b for webserver02).
User Data: The user data script installs Apache HTTP server (httpd), creates an HTML file displaying instance metadata, and starts the Apache service.
EC2 Instances: Two EC2 instances are created using the latest Amazon Linux 2 AMI, one in each Availability Zone. The instance type is t2.micro to qualify for the free tier.
Outputs: The public IPs of both EC2 instances (webserver01 and webserver02) are outputted so that they can be easily accessed in a browser.
*/

/*
Steps to Use:

1.Save the above Terraform configuration to a .tf file (e.g., ec2_instances.tf).

2.Run the following Terraform commands:
terraform init
terraform apply

3.After the deployment is complete, Terraform will output the public IPs of both instances.
You can then paste these IPs into your browser to see the instance details displayed.
*/