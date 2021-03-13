#!/bin/bash -xe
#
# Installing global packages (that need sudo).
#
cd $(dirname $0)

[ "$BOOT_USER" ] || BOOT_USER=$USER
[ "$BOOT_SSH_KEY" ] || BOOT_SSH_KEY="$(cat .ssh/id_rsa.pub)"

if ! sudo -v; then
    echo "Sudo does not work for this user, $USER."
    exit
fi

echo "[INFO] Installing common packages and Python3..."
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl git software-properties-common build-essential python3-dev python3-pip python3-venv

echo "[INFO] Installing Docker..."
curl -fsSL https://get.docker.com -o /tmp/get-docker.sh
sudo sh /tmp/get-docker.sh
sudo usermod -aG docker "$BOOT_USER"

echo "[INFO] Installing docker-compose..."
curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /tmp/docker-compose
chmod +x /tmp/docker-compose
sudo mv /tmp/docker-compose /usr/local/bin/docker-compose

echo "[INFO] Preparing files for user installation..."
cp .ssh/config /tmp
sudo chown $BOOT_USER:$BOOT_USER /tmp/config
cp .ssh/id_rsa.pub /tmp
sudo chown $BOOT_USER:$BOOT_USER /tmp/id_rsa.pub

echo "[INFO] Running user installation..."
sudo -Hu $BOOT_USER bash install-user.sh
