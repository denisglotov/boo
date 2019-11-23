#!/bin/bash

pip3 install --user setuptools

mkdir src
cd src
GIT_SSH_COMMAND='ssh -o StrictHostKeyChecking=no' git clone \
               git@github.com:hyperledger-labs/blockchain-integration-framework.git
cd blockchain-integration-framework
git remote add my git@github.com:denis-yu-glotov/blockchain-integration-framework.git
git fetch my
