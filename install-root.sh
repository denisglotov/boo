#!/bin/bash

[ "$BOOT_USER" ] || BOOT_USER='denis'
[ "$BOOT_SSH_KEY" ] || BOOT_SSH_KEY="$(cat .ssh/id_rsa.pub)"

LOG="/tmp/boo.log"

if ! sudo -v; then
    echo "Sudo does not work for this user, $USER." | tee -a $LOG
    exit
fi

sudo apt update
sudo apt install build-essential curl python3-dev

curl -LO https://raw.githubusercontent.com/denisglotov/.emacs.d/master/bin/create_user.sh
bash create-user.sh "$BOOT_USER" "$BOOT_SSH_KEY" | tee -a $LOG

echo "[INFO] Installing Docker..." | tee -a $LOG
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker "$BOOT_USER"

echo "[INFO] Installing docker-compose..." | tee -a $LOG
curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /tmp/docker-compose
chmod +x /tmp/docker-compose
sudo mv /tmp/docker-compose /usr/local/bin/docker-compose

echo "Installing Nodejs..." | tee -a $LOG
curl -L https://deb.nodesource.com/setup_8.x -o get-node8.sh
bash get-node8.sh
sudo apt install nodejs

cp .ssh/config /tmp
chmod $BOOT_USER:$BOOT_USER /tmp/sshconfig

cp .ssh/id_rsa.pub /tmp/id_rsa.pub
chmod $BOOT_USER:$BOOT_USER /tmp/id_rsa.pub

echo "Running user installation..." | tee -a $LOG
sudo -Hu $BOOT_USER bash userinit.sh

echo "All done." | tee -a $LOG
