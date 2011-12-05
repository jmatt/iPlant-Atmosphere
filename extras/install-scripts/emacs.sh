#!/bin/sh

############### Command-Line Configuration ################
while getopts vd: option
do
        case "${option}"
        in
                d) INSTALL_DIR=${OPTARG};;
                v) VERBOSE=true;;
                \?) usage
                    exit 1;; 
        esac
done

############### Distro Version ################
if [ -f /etc/issue ]; then
    DISTRO=`cat /etc/issue | cut -f 1 -d " " | awk -F "\n" 'NR==1 {print $1}'`
    # CentOS Ubuntu Debian Fedora
else
    DISTRO=$(uname -s)
    # Linux Darwin
fi

############### Install Emacs ################
if [ "$DISTRO" = "CentOS" ] || [ "$DISTRO" = "Fedora" ] ; then
    # Use yum
    COMMAND="yum"
    OPTIONS="-y"
    PACKAGES="emacs-nox"
fi

elif [ "$DISTRO" = "Ubuntu" ] || [ "$DISTRO" = "Debian" ] ; then
    # Use apt-get
    COMMAND="apt-get"
    OPTIONS="-y"
    PACKAGES="emacs-nox"
fi

echo "Installing emacs."

$COMMAND update -y
$COMMAND install $OPTIONS $PACKAGES


if [ $VERBOSE ]; then
    echo "Emacs is using $DISTRO."
    echo "Installed emacs."
fi

exit 0;
