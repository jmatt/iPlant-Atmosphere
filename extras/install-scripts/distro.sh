#!/bin/bash
#Steven Gregory & JMatt Peterson
#v 0.1.0

############### Distro Version ################
if [ -f /etc/issue ]; then
    export DISTRO=`cat /etc/issue | cut -f 1 -d " " | awk -F "\n" 'NR==1 {print $1}'`
    # CentOS Ubuntu Debian Fedora
else
    export DISTRO=$(uname -s)
    # Linux Darwin
fi
