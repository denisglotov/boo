#!/bin/bash -xe

cd
git clone https://github.com/denisglotov/.emacs.d
cd .emacs.d
git checkout dev
bin/install_emacs.sh
bin/install_tmux.sh -s

cd
mv /tmp/boo/.ssh/config .ssh/config
chmod 664 .ssh/config
mv /tmp/boo/.ssh/id_rsa.pub .ssh/id_rsa.pub
chmod 600 .ssh/id_rsa.pub

git config --global user.name "Denis Glotov"
