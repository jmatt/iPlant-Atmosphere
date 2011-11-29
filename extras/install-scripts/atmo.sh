#!/bin/bash
################## Default Variables ######################
VERBOSE="FALSE"
INSTALL_DIR=`pwd`

############### Command-Line Configuration ################
while getopts vd: option
do
        case "${option}"
        in
                d) INSTALL_DIR=${OPTARG};;
                v) VERBOSE="TRUE";;
                \?) usage
                    exit 1;; 
        esac
done

echo "Script variables"
echo $VERBOSE
echo $INSTALL_DIR
