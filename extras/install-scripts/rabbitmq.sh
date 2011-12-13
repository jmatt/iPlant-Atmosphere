#!/bin/sh
############### DISTRO CHECK ###################
if [ -z "$DISTRO" ]; then
	. ./distro.sh
fi

############### Install RabbitMQ ################
if [ "$DISTRO" = "CentOS" ] || [ "$DISTRO" = "Fedora" ] ; then
	wget http://www.rabbitmq.com/releases/rabbitmq-server/v2.7.0/rabbitmq-server-2.7.0-1.noarch.rpm
	# Use rpm
	COMMAND="rpm"
	OPTIONS="-i"
	FILE="rabbitmq-server-2.7.0-1.noarch.rpm"
elif [ "$DISTRO" = "Ubuntu" ] || [ "$DISTRO" = "Debian" ] ; then
	wget http://www.rabbitmq.com/releases/rabbitmq-server/v2.7.0/rabbitmq-server_2.7.0-1_all.deb
	#Use deb
	COMMAND="dpkg"
	OPTIONS="-i"
	FILE="rabbitmq-server-2.7.0-1_all.deb"
fi

$COMMAND $OPTIONS $FILE
