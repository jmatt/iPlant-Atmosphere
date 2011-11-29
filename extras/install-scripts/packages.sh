#!/bin/sh

if [ -f /etc/lsb-release ]; then
    . /etc/lsb-release
    DISTRO=$DISTRIB_ID
elif [ -f /etc/debian_version ]; then
    DISTRO=`cat /etc/lsb-release | cut -f 2 -d "=" | awk -F "\n" 'NR==1 {print $1}'`
    # XXX or Ubuntu
elif [ -f /etc/redhat-release ]; then
    DISTRO=`cat /etc/redhat-release | cut -f 1 -d " "`
    # XXX or CentOS or Fedora
else
    DISTRO=$(uname -s)
fi

echo "$DISTRO"
