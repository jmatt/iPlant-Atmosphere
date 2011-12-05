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

PACKAGES=""

if [ "$DISTRO" = "CentOS" ] || [ "$DISTRO" = "Fedora" ] ; then
    # Use yum
    COMMAND="yum"
    OPTIONS="-y"
    BUILD_PACKAGES="build-essentials gcc-c++"
    PYTHON_PACKAGES="python26 python26-devel python26-ldap python-boto"
    PACKAGES="${BUILD_PACKAGES} ${PYTHON_PACKAGES} mysql-server mysql-devel euca2ools httpd httpd-devel erlang openssl-devel git mod_ssl yum-plugin-downloadonly bzr"
elif [ "$DISTRO" = "Ubuntu" ] || [ "$DISTRO" = "Debian" ] ; then
    # Use apt-get
    COMMAND="apt-get"
    OPTIONS="-y"
    BUILD_PACKAGES="build-essentials gcc-c++"
    PYTHON_PACKAGES="python26 python26-devel python26-ldap python-boto"
    PACKAGES="${BUILD_PACKAGES} ${PYTHON_PACKAGES} mysql-server mysql-devel euca2ools httpd httpd-devel erlang openssl-devel git mod_ssl yum-plugin-downloadonly bzr"
fi

if [ $VERBOSE ]; then
    echo "Installing Packages."
fi
echo "Installing Packages."

$COMMAND update -y
$COMMAND install $OPTIONS $PACKAGES

if [ $VERBOSE ]; then
    echo "Packages is using $DISTRO."
    echo "Using the $COMMAND."
    echo "Installed $PACKAGES"
fi

exit 0;


