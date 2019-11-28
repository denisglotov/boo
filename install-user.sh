#!/bin/bash -xe

cd
git clone --branch dev https://github.com/denisglotov/.emacs.d
cd .emacs.d
bin/install_emacs.sh 26
bin/install_tmux.sh -s

cd
mv /tmp/config .ssh/config
chmod 644 .ssh/config
mv /tmp/id_rsa.pub .ssh/id_rsa.pub
chmod 600 .ssh/id_rsa.pub

git config --global user.name "Denis Glotov"
git config --global user.email denis@glotov.org

pip3 install --user -U pip

cp /tmp/boo/install-src.sh .

# [INFO] All done. Please log out and log in so local changes take effect.
#        Then use ./install-src.sh
