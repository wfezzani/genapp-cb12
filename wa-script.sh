#!/bin/bash
#hello let's start Wazi Analyze !    
wa-scan.sh project /home/wazi/data/project/project.dat
echo "projet scanné! "
wa-startup.sh -p "ztecztec" > startup.log
echo "Web UI disponible! "
