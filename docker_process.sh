#!/bin/bash

# Destination project folder on the Wazi Analyze container 
WA_DST_FOLDER=/home/wazi/data/project
# Source project folder on the Docker host
WA_SRC_FOLDER=$GIT_FOLDER/$JOB_BASE_NAME

# Retrieve two available ports from the ports range 29000 and 30000
BASE_PORT=29000
INCREMENT=1
port1=$BASE_PORT
isfree=$(netstat -taln | grep $port1)
while [[ -n "$isfree" ]]; do
  port1=$[port1+INCREMENT]
  isfree=$(netstat -taln | grep $port1)
done
port2=$[port1+INCREMENT]
isfree=$(netstat -taln | grep $port2)
while [[ -n "$isfree" ]]; do
  port2=$[port2+INCREMENT]
  isfree=$(netstat -taln | grep $port2)
done

# Fetch the Wazi Analyze image from the container registry and run the container
sudo podman pull docker.io/wfezzani/wazi-analyze:2023.2.0
sudo podman run -d -it -p $port1:5000 -p $port2:$port2 -e AZN_API_SERVER_PORT=$port2 --name GENAPP-${BUILD_NUMBER} docker.io/wfezzani/wazi-analyze:2023.2.0

# Copy project sources, the project.dat and the startup script from the Docker host to the Wazi container
sudo podman cp -a $WA_SRC_FOLDER/. GENAPP-${BUILD_NUMBER}:$WA_DST_FOLDER/source/
sudo podman cp $WA_SRC_FOLDER/project.dat GENAPP-${BUILD_NUMBER}:$WA_DST_FOLDER
sudo podman cp $WA_SRC_FOLDER/project_process.sh GENAPP-${BUILD_NUMBER}:$WA_DST_FOLDER
#sudo podman exec -e AZN_API_SERVER_PORT=$port2 GENAPP-${BUILD_NUMBER} env

# Run the startup script and generate the web UI link
sudo podman exec GENAPP-${BUILD_NUMBER} chmod 777 /home/wazi/data/project/project_process.sh
sudo podman exec GENAPP-${BUILD_NUMBER} /home/wazi/data/project/project_process.sh
echo "l'interface graphique est accessible à l'adresse suivante: https://10.3.20.206:$port1/login?api-server=10.3.20.206:$port2"
