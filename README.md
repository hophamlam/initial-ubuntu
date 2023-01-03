# This script will install

## Install fresh server

- [A new non-root user, turn on SSH-key login, disable root login](#install-new-non-root-user-for-a-fresh-server-with-ssh-key-log-in-and-disable-root)
- [Docker and Docker-compose](#docker-and-docker-compose)

## Install portainer and caddy (optional)

- [Portainer & Caddy server](#portainer-and-caddy-server)

# Before begin, prepare:

- Recommended linux distro: `ubuntu 20.04` (tested)

- `id_rsa.pub` - ssh-key in your local pc (here is id_rsa.pub) - copy and paste down the your id_rsa.pub somewhere or even here

```bash
## at your local pc
ssh-keygen -t rsa
cat ~/.ssh/id_rsa.pub ## !!IMPORTANT print PC public key OUT
ls -al ~/.ssh ## to organize keys -> check key
nano ~/.ssh/known_hosts ## In case you re-install server & remove all old ssh-key from the rebuilt server
```

- `root-password` of your server - from your provider

# Getting Started

1 script to go (and some prompt input 😂)

```bash
wget https://raw.githubusercontent.com/hophamlam/portainer-caddy-new-server/main/install-fresh-server.sh
sh install-fresh-server.sh && bash ./install-fresh-server.sh
```

## Install new non-root user for a fresh server with ssh-key log in and disable root

It will do apt update and upgrade, install git, clone jasonheecs repo. It will ask you:

### Do you want to create a new non-root user (Recommended)

![create-new-non-root-user](image/create-new-non-root-user.jpg)

```
Y
```

### Enter the username of the new user account:

![new-user-account](image/new-user-account.jpg)

`your-account` (not your-account, your real account)

### Full name, room number, work phone, home phone, other,...

Just `enter` for all default anwser

### Paste in the public SSH key for the new user

This is the important one, if pass the wrong key, you have to rebuild the server and re-do all the task again

![ssh-key](image/ssh-key.jpg)

Paste the `id_rsa.pub` we have prepared before

### Enter the timezone for the server (Default is 'Asia/Singapor')

![timezone](image/timezone.jpg)

`your-server-timezone`

mine is

```
Asia/Ho_Chi_Minh
```

Check [List of tz database time zones](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones)

## Next, the script will install Docker and Docker-compose

After getting it all done, we need to check if the script run well

# Double Check

## SSH-key login

Open a new terminal Git Bash

Try

```bash
ssh your-remote-server-ip
```

or

```bash
ssh your-account@your-remote-server-ip
```

If you can log in without input password, you good

## Docker and Docker-Compose

![docker](image/docker.jpg)

```bash
docker --version && docker-compose --version
```

# Portainer and Caddy server

## Getting started

### Clone the repo

```bash
git clone https://github.com/hophamlam/install-fresh-server-portainer-caddy.git && cd install-fresh-server-portainer-caddy
```

### Modify `.env` to suit yours

```bash
nano .env
```

### docker-compose up

```bash
sudo docker volume create --name=caddy_data && sudo docker-compose --env-file .env up -d
```

Done docker-compose then edit Caddyfile

## Point domain to container

### Modify `Caddyfile`

```bash
nano containers/caddy/Caddyfile
```

```bash
## example Caddyfile

email {
hophamlam92@yahoo.com
}

portainer.your-domain.com {
reverse_proxy portainer:9000
}
```

### Restart caddy container

Open browser hit `http://your-server-ip:9000`, login and restart the caddy container

**Or**

```bash
sudo docker restart caddy
```

![caddy-portainer-1](image/caddy-portainer-1.jpg)
![caddy-portainer-3](image/caddy-portainer-3.jpg)

### In case you need to kill and remove all container

```bash
sudo docker kill portainer
sudo docker kill caddy
sudo docker rm porainter
sudo docker rm caddy
sudo docker ps -a
#check if nothing display is good
```
