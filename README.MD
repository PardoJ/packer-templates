How to use
==========

Image creation
--------------

    packer build stretch.json

Box import
----------

    vagrant box add debian-strech build/debian-stretch.box

VM startup & init
-----------------

    vagrant up

Connection
----------
**If putty is used to connect to the VM, a private key have to be used.**

### Key creation

* Start puttygen
* Load .vagrant\machines\stretch\virtualbox\private_key
* Save as a private key

### And then, the connection
_I use conemu as a window console_

    %FAR%\conemu.exe /single /cmd %PUTTY%\putty.exe -ssh 127.0.0.1 -P 2222 -l vagrant -i private_key.ppk

**Else use**

    vagrant ssh