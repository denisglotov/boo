#!/bin/bash -xe

[ "$BOOT_USER" ] || BOOT_USER='denis'
[ "$BOOT_SSH_KEY" ] || BOOT_SSH_KEY="$(cat .ssh/id_rsa.pub)"

if ! sudo -v; then
    echo "Sudo does not work for this user, $USER."
    exit
fi

sudo apt update
sudo apt install build-essential curl python3-dev

curl -LO https://raw.githubusercontent.com/denisglotov/.emacs.d/master/bin/create_user.sh
bash create-user.sh "$BOOT_USER" "$BOOT_SSH_KEY"

echo "[INFO] Installing Docker..."
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker "$BOOT_USER"

echo "[INFO] Installing docker-compose..."
curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /tmp/docker-compose
chmod +x /tmp/docker-compose
sudo mv /tmp/docker-compose /usr/local/bin/docker-compose

echo "[INFO] Installing Nodejs..."
curl -L https://deb.nodesource.com/setup_8.x -o get-node8.sh
sudo bash get-node8.sh
sudo apt install nodejs

echo "[INFO] Preparing files for user installation..."
cp .ssh/config /tmp
sudo chown $BOOT_USER:$BOOT_USER /tmp/config
cp .ssh/id_rsa.pub /tmp
sudo chown $BOOT_USER:$BOOT_USER /tmp/id_rsa.pub

echo "[INFO] Running user installation..."
sudo -Hu $BOOT_USER bash install-user.sh

echo "All done!"
