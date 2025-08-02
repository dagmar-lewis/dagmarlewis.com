redeploy(){
  sudo docker stop portfolio
  sudo docker rm portfolio
  sudo docker rmi 464858727777.dkr.ecr.us-east-1.amazonaws.com/dagmarlewis_portfolio:latest
  sudo docker compose up -d
}

redeploy