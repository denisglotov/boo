#!/bin/bash -xe

cd
echo "[INFO] Installing emacs and tmux."
git clone https://github.com/denisglotov/.emacs.d
cd .emacs.d
git checkout dev || true
bin/install_emacs.sh
bin/install_tmux.sh -s

echo "[INFO] Starting emacs daemon."
nohup emacs --batch -L lisp -l init.el >/tmp/emacs.log 2>/tmp/emacs.err &

cd
echo "[INFO] Installing public key for key forwarding."
mv /tmp/config .ssh/config
chmod 644 .ssh/config
mv /tmp/id_rsa.pub .ssh/id_rsa.pub
chmod 600 .ssh/id_rsa.pub

git config --global user.name "Denis Glotov"
git config --global user.email denis@glotov.org

pip3 install --user -U pip

cp /tmp/boo/install-src.sh .

echo "[INFO] All done. Please log out and log in so local changes take effect."
echo "       Then use ./install-src.sh"
