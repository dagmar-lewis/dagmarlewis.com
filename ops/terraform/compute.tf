resource "aws_instance" "public" {
  ami                  = var.ami
  instance_type        = var.instance_type
  subnet_id            = aws_subnet.public.id
  security_groups      = [aws_security_group.public.id]
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
  lifecycle {
    create_before_destroy = true
  }
  # user_data = <<-EOF
  #                 #!/bin/bash
  #                 sudo apt-get update
  #                 sudo apt upgrade -y
  #                 sudo usermod -a -G docker 
  #                 sudo apt install -y ca-certificates curl gnupg lsb-release
  #                 sudo mkdir -p /etc/apt/keyrings
  #                 curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  #                 sudo echo  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  #                 sudo apt update
  #                 sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
  #                 sudo service docker start
  #                 sudo apt install unzip
  #                 curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  #                 unzip awscliv2.zip
  #                 sudo ./aws/install
  #                 cd /home/ubuntu
  #                 mkdir caddy
  #                 cd caddy
  #                 mkdir data config
  #                 sudo aws s3 cp s3://dagmarlewis.com-tf-files/Caddyfile .
  #                 sudo aws s3 cp s3://dagmarlewis.com-tf-files/docker-compose.yml .
  #                 aws ecr get-login-password --region us-east-1| sudo docker login --username AWS --password-stdin 464858727777.dkr.ecr.us-east-1.amazonaws.com/dagmarlewis_portfolio
  #                 sudo docker network create proxy-network
  #                 sudo docker compose up -d

  #                 EOF
  tags = {
    Name = "${var.project_name}_instance"
  }
}

# aws s3 cp Caddyfile  s3://dagmarlewis.com-tf-files

# aws s3 cp docker-compose.yml  s3://dagmarlewis.com-tf-files

