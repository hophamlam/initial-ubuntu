#!/bin/bash
echo "This script will install This script will install Docker & Docker-Compose & Portainer & Caddy"
echo "First it will do apt update and upgrade"
## apt-update
export DEBIAN_FRONTEND=noninteractive
sudo apt-get update &&
    apt-get -o Dpkg::Options::="--force-confold" upgrade -q -y --force-yes &&
    apt-get -o Dpkg::Options::="--force-confold" dist-upgrade -q -y --force-yes
echo "Done apt update and upgrade"
## Install git
echo "Install git"
sudo apt-get install git
echo "Done installing git"
echo "Clone jasonheecs repo"
## Clone jasonheecs repo and install ssh keys
git clone https://github.com/jasonheecs/ubuntu-server-setup.git && cd ~/ubuntu-server-setup/ && bash setup.sh
## Remove jasonheecs repo
sudo rm -rf ~/ubuntu-server-setup