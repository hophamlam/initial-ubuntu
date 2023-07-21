#!/bin/bash

# Function to display the menu
display_menu() {
  clear
  echo "=============================="
  echo "          MENU OPTIONS         "
  echo "=============================="
  echo "1. Install Docker and Docker-compose"
  echo "2. Install Caddy Server + Portainer CE + Wireguard Server"
  echo "3. Re-create Caddy-Portainer-WG stack"
  echo "4. Kill Caddy-Portainer-WG stack"
  echo "5. Update Caddyfile"
  echo "6. Install Portainer Agent"
  echo "7. Nothing yet"
  echo "q. Quit"
  echo "=============================="
  echo
  echo "Enter your choice (1-7) or 'q' to quit:"
}

# Function to handle option 1
handle_option1() {
  echo "Installing Docker and Docker-compose..."
  sudo apt update && sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
  sudo apt-cache policy docker-ce
  sudo apt install docker-ce -y
  sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
  echo "Check if Docker & Docker-Compose is installed"
  sudo docker --version && docker-compose --version
  read -p "Installation complete. Press enter to leave"
}

# Function to handle option 2
handle_option2() {
  echo "Install Caddy Server + Portainer CE + Wireguard Server... "
  sudo docker volume create --name=caddy_data
  cd ~/initial-ubuntu
  mkdir ./caddy
  mkdir ./wg
  wget https://raw.githubusercontent.com/hophamlam/initial-ubuntu/main/Caddyfile -P ./caddy/
  nano ./caddy/Caddyfile
  wget https://raw.githubusercontent.com/hophamlam/initial-ubuntu/main/docker-compose.yml
  nano ./docker-compose.yml
  wget https://raw.githubusercontent.com/hophamlam/initial-ubuntu/main/.env
  nano ./.env
  sudo docker compose -f ./docker-compose.yml up -d
  cd ~
  read -p "Press enter to continue"
}

# Function to handle option 3
handle_option3() {
  echo "Re-create Caddy-Portainer-WG stack..."
  cd ~/initial-ubuntu
  sudo docker compose up -d --force-recreate
  cd ~
  read -p "Press enter to continue"
}

# Function to handle option 4
handle_option4() {
  cd ~/initial-ubuntu
  echo "Kill Caddy-Portainer-WG stack... "
  sudo docker compose down
  cd ~
  read -p "Press enter to continue"
}

# Function to handle option 5
handle_option5() {
  echo "Update Caddyfile"
  cd ~/initial-ubuntu
  nano ./caddy/Caddyfile
  cd ~
  sudo docker restart caddy
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
