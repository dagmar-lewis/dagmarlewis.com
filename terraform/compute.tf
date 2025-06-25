resource "aws_instance" "instance" {
  ami             = "ami-0c46db45b631d4cf5"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.private_subnet.id
  security_groups = ["${aws_security_group.allow_cloudfront_managed.id}"]
  user_data       = <<-EOF
                  #!/bin/bash
                  sudo yum update -y
                  sudo yum install git -y
                  sudo yum -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
                  sudo service docker start
                  systemctl enable docker
                  git clone https://github.com/dagmar-lewis/dagmarlewis.com.git
                  cd dagmarlewis.com
                  cd frontend
                  sudo docker build -t portfolio -f Dockerfile .
                  sudo docker-compose up -d
                  docker run -p 3000:3000 portfolio:5
                  EOF
  tags = {
    Name = "dagmarlewis_portfolio"
  }
}
