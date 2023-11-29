#!/bin/bash
echo "hello world"
scp -r ${WORKSPACE} root@10.3.20.206:/var/tmp/
ssh root@10.3.20.206 "whoami;echo 'build number '+${BUILD_NUMBER};
                      export BUILD_NUMBER=$BUILD_NUMBER;
                       echo 'build name '+${BUILD_NAME};
                       echo 'workspace name '+${WORKSPACE};
                       echo 'WA_SRC_FOLDER '+${WA_SRC_FOLDER};
                       sudo chmod 777  /var/tmp/genapp-github/getports-jks1.sh;
                       cd /var/tmp/genapp-github;
                       ./getports-jks1.sh"
