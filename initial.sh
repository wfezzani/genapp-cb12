#!/bin/bash
# UserID and IP Adress of the Docker host 
USER=root
IPADDRESS=10.3.20.206
# Destinantion folder on the Docker host 
GIT_FOLDER=/var/tmp/
# Tranfer the git repository from the Jenkins server to the Docker server
scp -r ${WORKSPACE} $USER@$IPADDRESS:$GIT_FOLDER
# SSH to the Docker host and execute the script
ssh $USER@$IPADDRESS "export BUILD_NUMBER=$BUILD_NUMBER;
                      export GIT_FOLDER=$GIT_FOLDER;
                      export IPADDRESS=$IPADDRESS;
                      export JOB_BASE_NAME=$JOB_BASE_NAME;
                       sudo chmod 777  $GIT_FOLDER/$JOB_BASE_NAME/docker_process.sh;
                       cd $GIT_FOLDER/$JOB_BASE_NAME;
                       ./docker_process.sh"
