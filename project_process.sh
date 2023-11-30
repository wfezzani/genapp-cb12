#!/bin/bash
GUI_PASSWORD=password
wa-scan.sh project /home/wazi/data/project/project.dat
echo "project scan completed :) "
wa-startup.sh -p $GUI_PASSWORD > startup.log
echo "Wazi Web UI is now available ! "
