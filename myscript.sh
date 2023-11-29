#!/bin/bash
echo "hello world"
scp -r ${WORKSPACE} root@10.3.20.206:/var/tmp/
ssh root@10.3.20.206 "whoami;echo 'build number '+${BUILD_NUMBER};
                       echo 'build name '+${BUILD_NAME};
                       echo 'workspace name '+${WORKSPACE};
                       echo 'WA_SRC_FOLDER '+${WA_SRC_FOLDER}"
