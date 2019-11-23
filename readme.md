Boot scripts for new host
=========================

[![Build status]](https://travis-ci.org/denisglotov/boo)

[Build status]: https://travis-ci.org/denisglotov/boo.svg?branch=master

``` shell
#!/bin/bash
sudo apt update
sudo apt install apt-transport-https ca-certificates curl git software-properties-common
echo url="https://www.duckdns.org/update?domains=${DUCKDOMAIN}&token=${DUCKTOKEN}&ip=" |
    curl -k -o /tmp/boo.log -K -
git clone https://github.com/denisglotov/boo.git
BOOT_USER='denis' BOOT_SSH_KEY='...' boo/installl-root.sh
```

Installs
* Latest docker,
* docker-compose 1.24.1,
* nodejs 8, npm.

Log goes to `/tmp/boo.log`.
