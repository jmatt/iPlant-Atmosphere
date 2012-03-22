#!/bin/bash
#
# nodejs install. http://nodejs.org/
#
# Steven Gregory & JMatt Peterson (:twitter "@jmatt" :email "jmatt@iplantcollaborative.org")
#
# Changes
# v 0.1.0 - created 


#Distribution Information#####
if [ -z "$GETOPT" ]; then
	. ./getOpts.sh
fi
if [ -z "$DISTRO" ]; then
	. ./distro.sh
fi

#ENVIRONMENTAL VARIABLE SETUP#
export PATH=$PATH:/usr/local/bin

###INSTALL NODE JS############
wget http://nodejs.org/dist/v0.6.13/node-v0.6.13.tar.gz
tar -xzvf node-v0.6.13.tar.gz
cd node-v0.6.13
./configure
make
sudo make install

#########INSTALL NPM##########
curl http://npmjs.org/install.sh > install.npm.sh
sudo -E sh ./install.npm.sh

