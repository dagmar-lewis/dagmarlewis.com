resource "aws_instance" "instance" {
  ami                  = "ami-0c46db45b631d4cf5" #wordpress "ami-0c46db45b631d4cf5" aws linux"ami-05ffe3c48a9991133"
  instance_type        = "t2.micro"
  subnet_id            = aws_subnet.private_subnet.id
  security_groups      = [aws_security_group.allow_cloudfront_managed.id, aws_security_group.endpoint-sg.id, aws_security_group.egress_endpoint_sg]
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
  
  # user_data       = <<-EOF
  #                 #!/bin/bash
  #                 sudo yum install -y docker
  #                 sudo service docker start
  #                 sudo docker run -d -p 8080:80 --name it-tools -it corentinth/it-tools

  #                 EOF
  tags = {
    Name = "dagmarlewis_portfolio"
  }
}



