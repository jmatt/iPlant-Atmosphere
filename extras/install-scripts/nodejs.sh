#!/bin/bash
#Steven Gregory & JMatt Peterson
#v 0.1.0

#Distribution Information
. ./getOpts.sh
. ./distro.sh
echo "stuff"
exit
#ENVIRONMENTAL VARIABLE SETUP#
export PATH=$PATH:/usr/local/bin

###INSTALL NODE JS###
wget http://nodejs.org/dist/v0.6.4/node-v0.6.4.tar.gz
tar -xzvf node-v0.6.4.tar.gz
cd node-v0.6.4
./configure
make
sudo make install

###INSTALL NPM###
curl http://npmjs.org/install.sh > install.npm.sh
sudo -E sh ./install.npm.sh

