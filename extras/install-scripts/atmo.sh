#!/bin/bash
if [[ $EUID -ne 0 ]]; then
	echo "This script must be run as root" 1>&2
	exit 1
fi

################## Default Variables ######################
VERBOSE="FALSE"
INSTALL_DIR=`pwd`

. ./getOpts.sh

echo "Script variables"
echo $VERBOSE
echo $INSTALL_DIR
sh packages.sh 
sh py.sh 
sh nodejs.sh
sh redis.sh
sh faye.sh
