#!/bin/bash
# UserID and PASSWORD for the Docker host 
USER=root
IPADDRESS=10.3.20.206
# Destinantion folder on the Docker host 
GIT_FOLDER=/var/tmp/
echo "build name= "$JOB_BASE_NAME
# Tranfer the git repository from the Jenkins server to the Docker server
scp -r ${WORKSPACE} $USER@$IPADDRESS:$GIT_FOLDER
ssh $USER@$IPADDRESS "whoami;echo 'build number '+${BUILD_NUMBER};
                      export BUILD_NUMBER=$BUILD_NUMBER;
                       sudo chmod 777  $GIT_FOLDER/genapp-github/getports-jks1.sh;
                       cd /var/tmp/genapp-github;
                       ./getports-jks1.sh"
