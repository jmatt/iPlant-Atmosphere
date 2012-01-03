#!/bin/bash
#Steven Gregory & JMatt Peterson
#v 0.1.0
#Distribution Information#####
if [ -z "$GETOPT" ]; then
        . ./getOpts.sh
fi
if [ -z "$DISTRO" ]; then
        . ./distro.sh
fi


sudo -E npm install faye -g

