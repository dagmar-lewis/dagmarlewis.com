resource "aws_instance" "instance" {
  ami                  = "ami-05ffe3c48a9991133" #wordpress "ami-0c46db45b631d4cf5" aws linux"ami-05ffe3c48a9991133"
  instance_type        = "t2.micro"
  subnet_id            = aws_subnet.private_subnet.id
  security_groups      = [aws_security_group.allow_cloudfront_managed.id, aws_security_group.endpoint-sg.id, aws_security_group.egress_endpoint_sg.id]
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  user_data       = <<-EOF
                  #!/bin/bash
                  sudo yum install -y docker
                  sudo service docker start
                  sudo docker pull dagmarl/portfolio:latest
                  sudo docker run -p 3000:80 dagmarl/portfolio:latest

                  EOF
  tags = {
    Name = "dagmarlewis_portfolio"
  }
}



