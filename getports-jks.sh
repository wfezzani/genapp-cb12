#!/bin/bash
echo "shell pid= " $$
BASE_PORT=29000
INCREMENT=1
port1=$BASE_PORT
isfree=$(netstat -taln | grep $port1)
while [[ -n "$isfree" ]]; do
  port1=$[port1+INCREMENT]
  isfree=$(netstat -taln | grep $port1)
done
echo "First Usable Port: $port1"
port2=$[port1+INCREMENT]
isfree=$(netstat -taln | grep $port2)
while [[ -n "$isfree" ]]; do
  port2=$[port2+INCREMENT]
  isfree=$(netstat -taln | grep $port2)
done
echo "Second Usable Port: $port2"
sudo podman pull docker.io/wfezzani/wazi-analyze:2023.2.0
echo "port1 =" $port1
echo "port2 =" $port2
sudo podman run -d -it -p $port1:5000 -p $port2:$port2 -e AZN_API_SERVER_PORT=$port2 --name GENAPP-${BUILD_NUMBER} docker.io/wfezzani/wazi-analyze:2023.2.0
sudo podman cp -a $WA_SRC_FOLDER/. GENAPP-${BUILD_NUMBER}:$WA_DST_FOLDER/source/
sudo podman cp $WA_SRC_FOLDER/project.dat GENAPP-${BUILD_NUMBER}:$WA_DST_FOLDER
sudo podman cp $WA_SRC_FOLDER/wa-script.sh GENAPP-${BUILD_NUMBER}:$WA_DST_FOLDER
#sudo podman exec -e AZN_API_SERVER_PORT=$port2 GENAPP-${BUILD_NUMBER} env
sudo podman exec GENAPP-${BUILD_NUMBER} chmod 777 /home/wazi/data/project/wa-script.sh
sudo podman exec GENAPP-${BUILD_NUMBER} /home/wazi/data/project/wa-script.sh
echo "l'interface graphique est accessible à l'adresse suivante: https://10.3.20.206:$port1/login?api-server=10.3.20.206:$port2"
