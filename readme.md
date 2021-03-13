Boot scripts for new host
=========================

[![Build status]](https://travis-ci.org/denisglotov/boo)

[Build status]: https://travis-ci.org/denisglotov/boo.svg?branch=master

``` shell
#!/bin/bash
BOOT_USER='denis'     # <--- add your username
DUCKDOMAIN='vultrone' # <--- domain for duckdns
DUCKTOKEN='...'       # <--- token for duckdns

sudo apt update
sudo apt install apt-transport-https ca-certificates curl git software-properties-common
echo url="https://www.duckdns.org/update?domains=${DUCKDOMAIN}&token=${DUCKTOKEN}&ip=" | curl -k -o /tmp/boo.log -K -
curl https://raw.githubusercontent.com/denisglotov/boo/master/create-user.sh | bash -s -- "$BOOT_USER" "$(curl https://glotov.org/ssh)"
```

After the VM is created, run

``` shell
ssh-keygen -f "/home/denis/.ssh/known_hosts" -R "vultrone.duckdns.org"
ssh vultrone "ssh-keyscan github.com >>~/.ssh/known_hosts && git clone -b dev https://github.com/denisglotov/boo.git && boo/install-root.sh"
```

Installs
--------

* Latest docker (https://docs.docker.com/engine/install/ubuntu/),
* docker-compose 1.27.4 (https://docs.docker.com/compose/install/),
* python3, latest pip3.

Logs
----

Log go to `/tmp/boo.log`.


Ssh agent forwarding
--------------------

Note that you need to use `ssh-agent` to make your keys forwarded. I use the
following snippet in `.bashrc`:

``` shell
if [ ! -S /tmp/ssh_auth_sock ]; then
    echo -e "Starting the ssh-agent: "
    eval `ssh-agent`
    ln -sf "$SSH_AUTH_SOCK" /tmp/ssh_auth_sock
fi
export SSH_AUTH_SOCK=/tmp/ssh_auth_sock
ssh-add -l > /dev/null || ssh-add
```

And the following in record `.ssh/config`:

    Host vultrone
    Hostname vultrone.duckdns.org
    User denis
    ForwardAgent yes
    IdentityFile ~/.ssh/id_rsa
    IdentitiesOnly yes


Ssh keys
--------

[!] Remember to keep your current public keys committed to
`.ssh/id_rsa.pub`. Alternatively, update `create-user.sh` argument.
