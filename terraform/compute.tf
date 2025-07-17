resource "aws_instance" "instance" {
  ami                  = var.ami
  instance_type        = var.instance_type
  subnet_id            = aws_subnet.private_subnet.id
  security_groups      = [aws_security_group.allow_cloudfront_managed.id, aws_security_group.ssm_sg.id, aws_security_group.egress_endpoint_sg.id,aws_security_group.s3_endpoint.id]
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  user_data       = <<-EOF
                  #!/bin/bash
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
    Name = "${var.project_name}_instance"
  }
}

# aws s3 cp Caddyfile  s3://dagmarlewis.com-tf-files

# aws s3 cp docker-compose.yml  s3://dagmarlewis.com-tf-files

