#!/bin/bash -xe
#
# Install user-specific packages
#
cd
echo "[INFO] Installing emacs and tmux."
git clone https://github.com/denisglotov/.emacs.d
cd .emacs.d && git checkout dev || true
bin/install_emacs.sh
bin/install_tmux.sh -s

echo "[INFO] Starting emacs daemon."
nohup emacs --batch -L lisp -l init.el >/tmp/emacs.log 2>/tmp/emacs.err &

cd
echo "[INFO] Installing public key for key forwarding."
cp boo/.ssh/config .ssh/config
chmod 644 .ssh/config
cp boo/.ssh/id_*.pub .ssh/
chmod 600 .ssh/id_*.pub

git config --global user.name "Denis Glotov"
git config --global user.email denis@glotov.org

python -m pip install --upgrade pip
pip install --user flake8
mkdir bin src

echo "[INFO] All done. Please log out and log in so local changes take effect."
echo "       Then use 'source boo/install-src.sh'."
