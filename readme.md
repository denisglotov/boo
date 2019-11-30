Boot scripts for new host
=========================

[![Build status]](https://travis-ci.org/denisglotov/boo)

[Build status]: https://travis-ci.org/denisglotov/boo.svg?branch=master

``` shell
#!/bin/bash
BOOT_USER='denis'  # <--- add your username
BOOT_SSH_KEY='...' # <--- add your key here

sudo apt update
sudo apt install apt-transport-https ca-certificates curl git software-properties-common
echo url="https://www.duckdns.org/update?domains=${DUCKDOMAIN}&token=${DUCKTOKEN}&ip=" | curl -k -o /tmp/boo.log -K -
git clone https://github.com/denisglotov/boo.git /tmp/boo
/tmp/boo/create-user.sh "$BOOT_USER" "$BOOT_SSH_KEY"
```

Installs
* Latest docker,
* docker-compose 1.24.1,
* python3, latest pip3,
* nodejs8, npm.

Log goes to `/tmp/boo.log`.
