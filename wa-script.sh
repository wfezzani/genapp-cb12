#!/bin/bash
wa-scan.sh project /home/wazi/data/project/project.dat
echo "project scan completed :) "
wa-startup.sh -p "ztecztec" > startup.log
echo "Wazi Web UI is now available ! "
