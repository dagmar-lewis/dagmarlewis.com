resource "aws_instance" "instance" {
  ami                  = "ami-020cba7c55df1f615" #wordpress "ami-0c46db45b631d4cf5" aws linux"ami-05ffe3c48a9991133"
  instance_type        = "t2.micro"
  subnet_id            = aws_subnet.private_subnet.id
  security_groups      = [aws_security_group.allow_cloudfront_managed.id, aws_security_group.endpoint-sg.id, aws_security_group.egress_endpoint_sg.id,aws_security_group.s3_endpoint.id]
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  user_data       = <<-EOF
                  #!/bin/bash
                  sudo su - ubuntu
                  sudo apt-get update
                  sudo apt upgrade -y
                  sudo usermod -a -G docker 
                  sudo apt install -y ca-certificates curl gnupg lsb-release
                  sudo mkdir -p /etc/apt/keyrings
                  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
                  sudo echo  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
                  sudo apt update
                  sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
                  sudo service docker start
                  sudo apt install unzip
                  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
                  unzip awscliv2.zip
                  sudo ./aws/install
                  cd /home/ubuntu
                  mkdir caddy
                  cd caddy
                  mkdir data config
                  sudo aws s3 cp s3://dagmarlewis.com-tf-files/Caddyfile .
                  sudo aws s3 cp s3://dagmarlewis.com-tf-files/docker-compose.yml .
                  sudo docker network create proxy-network
                  sudo docker compose up -d

                  EOF
  tags = {
    Name = "dagmarlewis_portfolio"
  }
}

# aws s3 cp Caddyfile  s3://dagmarlewis.com-tf-files

# aws s3 cp docker-compose.yml  s3://dagmarlewis.com-tf-files

