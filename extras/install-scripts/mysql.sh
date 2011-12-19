#!/bin/sh
#Steven Gregory & JMatt Peterson
#v 0.1.0

############### Distribution & Option Information ##############
if [ -z "$GETOPT" ]; then
        . ./getOpts.sh
fi
if [ -z "$DISTRO" ]; then
        . ./distro.sh
fi

