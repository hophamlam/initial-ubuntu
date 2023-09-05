#!/bin/bash

# Function to display the menu
display_menu() {
  clear
  echo "=============================="
  echo "          MENU OPTIONS         "
  echo "=============================="
  echo "1. Install Docker and Docker-compose"
  echo "2. Install Caddy-Docker-Proxy from lucaslorentz & pre-define domain"
  echo "3. Install Portainer CE, Portainer Agent, Wireguard VPN, Uptime Kuma"
  echo "4. "
  echo "5. "
  echo "6. Install Portainer Agent"
  echo "7. Nothing yet"
  echo "q. Quit"
  echo "=============================="
  echo
  echo "Enter your choice (1-7) or 'q' to quit:"
}

# Function to handle option 1
handle_option1() {
  echo "Installing Docker and Docker Compose using convenience script..."
  curl -fsSL https://get.docker.com | bash
  echo "Check if Docker & Docker-Compose is installed"
  sudo usermod -aG docker $(whoami)
  docker --version && docker compose version
  sudo chmod 666 /var/run/docker.sock
  sudo gpasswd -a $USER docker
  echo "Test docker run hello-world"
  docker run hello-world
  echo "You can run docker in rootless mode from now"
}

# Function to handle option 2
handle_option2() {
  echo "Installing Caddy-Docker-Proxy from lucaslorentz... "
  echo "Cloning hophamlam/initial-ubuntu repo"
  git -C ~/initial-ubuntu pull || git clone https://github.com/hophamlam/initial-ubuntu.git ~/initial-ubuntu
  cd ~/initial-ubuntu/docker
  docker network create caddy
  nano ./docker-compose.caddy.yml && docker compose -f ./docker-compose.caddy.yml up -d
  echo "Modifing domains for reverse proxy"
  cp .env.sample .env
  nano .env
  read -p "Press enter to continue"
  cd ~/initial-ubuntu
}

# Function to handle option 3
handle_option3() {
  echo "Installing Portainer CE, Portainer Agent, Wireguard VPN, Uptime Kuma"
  echo "Installing Portainer CE"
  git -C ~/initial-ubuntu pull || git clone https://github.com/hophamlam/initial-ubuntu.git ~/initial-ubuntu
  docker volume create portainer_data
  cd ~/initial-ubuntu/docker
  nano ./docker-compose.portainer.yml && docker compose -f ./docker-compose.portainer.yml up -d
  echo "Installing Portainer Agent"
  docker run -d -p 9001:9001 --name portainer_agent --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/docker/volumes:/var/lib/docker/volumes portainer/agent:latest
  echo "Installing wg-easy"
  nano ./docker-compose.wgeasy.yml && docker compose -f ./docker-compose.wgeasy.yml up -d
  echo "Installing uptime kuma from louislam"
  docker volume create uptimekuma_data
  nano ./docker-compose.uptimekuma.yml && docker compose -f ./docker-compose.uptimekuma.yml up -d
  cd ~/initial-ubuntu
  read -p "Press enter to continue"
}

# Function to handle option 4
handle_option4() {
  echo "Kill Caddy-Portainer-WG stack... "
  read -p "Press enter to continue"
}

# Function to handle option 5
handle_option5() {
  echo "Update Caddyfile"
  read -p "Press enter to continue"
}

# Function to handle option 6
handle_option6() {
  echo "Install Portainer Agent"
  sudo docker run -d -p 9001:9001 --name portainer_agent --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/docker/volumes:/var/lib/docker/volumes portainer/agent:latest
  read -p "Press enter to continue"
}

# Function to handle option 7
handle_option7() {
  echo "Nothing yet"
  read -p "Press enter to continue"
}

# Main script logic
while true; do
  display_menu
  read -r choice

  case $choice in
  1)
    handle_option1
    ;;
  2)
    handle_option2
    ;;
  3)
    handle_option3
    ;;
  4)
    handle_option4
    ;;
  5)
    handle_option5
    ;;
  6)
    handle_option6
    ;;
  7)
    handle_option7
    ;;
  q | Q)
    echo "Exiting..."
    exit 0
    ;;
  *)
    echo "Invalid choice. Please try again."
    read -p "Press enter to continue"
    ;;
  esac
done
