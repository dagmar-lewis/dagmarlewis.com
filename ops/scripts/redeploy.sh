sudo docker stop portfolio 
sudo docker rm portfolio
sudo docker image rm dagmarl/portfolio:main
cd caddy
sudo docker compose up -d 