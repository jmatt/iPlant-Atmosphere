#!/bin/bash
#Steven Gregory & JMatt Peterson
#v 0.1.0
function usage {
	echo "---"
	echo "Available commands:"
	echo "-d INSTALL_DIR : Choose the directory to install atmosphere"
	echo "-v : Enable verbosity"
	echo "---"
}

############### Command-Line Configuration ################
while getopts vd: option
do
        case "${option}"
        in
                d) export INSTALL_DIR=${OPTARG};;
                v) export VERBOSE=true;;
                \?) usage
                    exit 1;;
        esac
done

#Pre-Processing
# Is directory writeable, does it exist, create if not.. 
