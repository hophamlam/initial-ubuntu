# Setup SSH public key for server

```bash
#  check key
ls -al ~/.ssh
# You can do
rm -rf ~/.ssh/* ##to remove everything in your .ssh folder.
# tạo key
ssh-keygen -C "ten-key"
# copy key
cat ~/.ssh/ten-key
cat ~/.ssh/ten-key.pub ## !!!IMPORTANTprint PC public key OUT HERE
nano ~/.ssh/authorized_keys
# change port
nano /etc/ssh/sshd_config
service ssh restart
```

# Install Logging into server using SSH-key

```bash
## at local PC
ssh-keygen -t rsa
cat ~/.ssh/id_rsa.pub ###  !!!IMPORTANTprint PC public key OUT HERE

### example key
ssh-rsa AH^&*T*GHJIBKAJSD lamgaopc
## log in to server as root
ssh root@server
### apt-update
export DEBIAN_FRONTEND=noninteractive
apt-get update &&
    apt-get -o Dpkg::Options::="--force-confold" upgrade -q -y --force-yes &&
    apt-get -o Dpkg::Options::="--force-confold" dist-upgrade -q -y --force-yes
### install git
sudo apt-get install git
### clone jasonheecs repo
git clone https://github.com/jasonheecs/ubuntu-server-setup.git && cd ~/ubuntu-server-setup/ && bash setup.sh
### Paste in the public SSH key for the new user:
### ---> Paste in the public key
### Running setup script...
### Enter the timezone for the server (Default is 'Asia/Singapore'):
Asia/Ho_Chi_Minh
### Timezone is set to Asia/Ho_Chi_Minh
### Installing Network Time Protocol...
### Setup Done! Log file is located at output.lo

## Open new terminal to test
ssh user@ip
```

# Install Docker && Docker-Compose && Portainer && Nginx Proxy Manager

## [Install docker](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04)

```bash
sudo apt update && sudo apt install apt-transport-https ca-certificates curl software-properties-common -y && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" && apt-cache policy docker-ce && sudo apt install docker-ce -y && sudo systemctl status docker
```

Output is below

```bash
Output
● docker.service - Docker Application Container Engine
     Loaded: loaded (/lib/systemd/system/docker.service; enabled; vendor preset: enabled)
     Active: active (running) since Tue 2020-05-19 17:00:41 UTC; 17s ago
TriggeredBy: ● docker.socket
       Docs: https://docs.docker.com
   Main PID: 24321 (dockerd)
      Tasks: 8
     Memory: 46.4M
     CGroup: /system.slice/docker.service
             └─24321 /usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock
```

## Docker Compose

```bash
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose &&sudo chmod +x /usr/local/bin/docker-compose && docker-compose --version
```

## Portainer

```bash
sudo docker volume create portainer_data && sudo docker run -d -p 8000:8000 -p 9443:9443 --name portainer \
    --restart=always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v portainer_data:/data \
    portainer/portainer-ce:latest
```

## Nginx Proxy Manager

```bash
git clone https://github.com/hophamlam/install-new-server.git
cd ~/nginx-proxy-manager
docker-compose up -d
```

Logging information: <code>admin@example.com</code> | <code>change</code>

# One command install script

Will update soon!
