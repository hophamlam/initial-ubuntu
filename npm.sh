echo "clone git repo"
git clone https://github.com/hophamlam/nginx-proxy-manager.git
echo "docker-compose up"
cd ~/nginx-proxy-manager
docker-compose up -d
echo "http://your-host-ip:81"
echo "admin@example.com / changeme"