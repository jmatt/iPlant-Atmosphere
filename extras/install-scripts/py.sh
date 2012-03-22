#!/bin/bash
#
# Python and python dependencies.
#
# Steven Gregory & JMatt Peterson (:twitter "@jmatt" :email "jmatt@iplantcollaborative.org")
# Changes
# v 0.1.0 - created
 
#Options Information##########
if [ -z "$GETOPT" ]; then
	. ./getOpts.sh
fi
#Distribution Information#####
if [ -z "$DISTRO" ]; then
	. ./distro.sh
fi

#ENVIRONMENTAL VARIABLE SETUP#
#export PATH=$PATH:/usr/local/bin

###INSTALL Python############
#wget http://nodejs.org/dist/v0.6.13/node-v0.6.13.tar.gz
#tar -xzvf node-v0.6.13.tar.gz
#cd node-v0.6.13
#./configure
#make
#sudo make install

#########INSTALL Python Dependencies##########
#curl http://npmjs.org/install.sh > install.npm.sh
#sudo -E sh ./install.npm.sh

