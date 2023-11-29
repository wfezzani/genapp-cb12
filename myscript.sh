#!/bin/bash
echo "hello world"
scp ${WORKSPACE} root@10.3.20.206:/var/tmp/
ssh root@10.3.20.206 "whoami;ifconfig"
