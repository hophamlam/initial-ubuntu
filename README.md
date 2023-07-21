- [This script will install:](#this-script-will-install)
- [Initial new fresh server using jasonheecs repo](#initial-new-fresh-server-using-jasonheecs-repo)
  - [Recommendation](#recommendation)
  - [Getting Started](#getting-started)
  - [Check if everything is good](#check-if-everything-is-good)
- [My customized menu script to install:](#my-customized-menu-script-to-install)

# This script will install:

- Initial new fresh server using [jasonheecs repo](https://github.com/jasonheecs/ubuntu-server-setup) (a new non-root user, turn on SSH-key login, disable root login)
- [Docker](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04) and [Docker-compose](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-20-04)
- [Portainer CE](https://docs.portainer.io/start/install-ce)
- [Caddy-server](https://caddyserver.com/)
- A wireguard server with fancy UI using [WeeJeWel repo](https://github.com/WeeJeWel/wg-easy)

# Initial new fresh server using [jasonheecs repo](https://github.com/jasonheecs/ubuntu-server-setup)

## Recommendation

- Recommended linux distro: `ubuntu 20.04` (tested)

- `id_rsa.pub` - ssh-key in your local pc (here is `id_rsa.pub`) - copy and paste down the your id_rsa.pub somewhere or even here

```bash
## at your local pc
ssh-keygen -t rsa
cat ~/.ssh/id_rsa.pub ## !!IMPORTANT print PC public key OUT
ls -al ~/.ssh ## to organize keys -> check key
nano ~/.ssh/known_hosts ## In case you re-install server & remove all old ssh-key from the rebuilt server
```

- `root-password` of your server - from your provider

## Getting Started

1 script to go (and some prompt input 😂)

```bash
apt-get update &&
apt-get install git &&
git clone https://github.com/jasonheecs/ubuntu-server-setup.git &&
bash ./ubuntu-server-setup/setup.sh
sudo rm -rf ubuntu-server-setup
```

It will do `apt update`, `install git`, clone [jasonheecs repo](https://github.com/jasonheecs/ubuntu-server-setup) (`Install new non-root user` for a fresh server with `ssh-key log in` and `disable root login`). It will ask you (prompts):

- **Do you want to create a new non-root user (Recommended)**: `Y`
- **Enter the username of the new user account:** `your-account` (not your-account, your real account)
- **Full name, room number, work phone, home phone, other,...**: Just `enter` for all default anwser (6 enters)
- **Paste in the public SSH key for the new user**: This is the important one, if pass the wrong key, you have to rebuild the server and re-do all the task again. Paste the `id_rsa.pub` we have prepared before
- **Enter the timezone for the server (Default is 'Asia/Singapore')**: `your-server-timezone` (mine is Asia/Ho_Chi_Minh) Check [List of time zones](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones)

<img src="image/create-new-non-root-user.jpg" width="300"><img src="image/new-user-account.jpg" width="300"><img src="image/ssh-key.jpg" width="300"><img src="image/timezone.jpg" width="300"><img src="https://raw.githubusercontent.com/hophamlam/initial-server/main/image/create-new-non-root-user.jpg" width="300">

## Check if everything is good

**SSH-key login:**
Open a new terminal Git Bash, try `ssh your-remote-server-ip` or `ssh your-account@your-remote-server-ip`

If you can log in without input password, you good and **from now you should exit root user ssh session and using** `ssh user@your-server`

# My customized menu script to install:

- [Portainer CE](https://docs.portainer.io/start/install-ce)
- [Caddy-server](https://caddyserver.com/)
- [Wireguard Server](https://github.com/WeeJeWel/wg-easy)

Download script and run

```bash
wget https://raw.githubusercontent.com/hophamlam/initial-ubuntu/main/menu.sh -P ~/initial-ubuntu/ && bash ~/initial-ubuntu/menu.sh
```

Re-run

```bash
bash ~/initial-ubuntu/menu.sh
```
