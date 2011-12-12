#!/bin/sh
if [ -z "$GETOPT" ]; then
        . ./getOpts.sh
fi
if [ -z "$DISTRO" ]; then
        . ./distro.sh
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


