Boot scripts for new host
=========================

[![Build status]](https://travis-ci.org/denisglotov/boo)

[Build status]: https://travis-ci.org/denisglotov/boo.svg?branch=hyperledger-labs

``` shell
#!/bin/bash
BOOT_USER='denis'  # <--- add your username

sudo sed -i '/Port /aPort 443' /etc/ssh/sshd_config
sudo /etc/init.d/ssh restart
sudo apt update
sudo apt install apt-transport-https ca-certificates curl git software-properties-common
echo url="https://www.duckdns.org/update?domains=${DUCKDOMAIN}&token=${DUCKTOKEN}&ip=" | curl -k -o /tmp/boo.log -K -
git clone --branch hyperledger-labs https://github.com/denisglotov/boo.git /tmp/boo >>$LOG
/tmp/boo/create-user.sh "$BOOT_USER" "$(cat /tmp/boo/.ssh/id_rsa.pub)"
```

Installs
* Latest docker,
* docker-compose 1.24.1,
* python3, latest pip3,
* nodejs8, npm,
* open JDK 8.

Log goes to `/tmp/boo.log`.
