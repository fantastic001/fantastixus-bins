#!/bin/sh

is_osx() {
    if [ "$(uname)" = "Darwin" ]; then
        return 0
    else
        return 1
    fi
}

if is_osx; then
    echo "Installing launchd agents"
    mkdir -p ~/Library/LaunchAgents
    cp -r launchd/* ~/Library/LaunchAgents/

fi


SUDO=""

if is_osx; then 
    sudo mkdir /opt/fantastixus/
    sudo cp -r bin /opt/fantastixus/
    sudo cp -r sbin /opt/fantastixus/
    sudo cp functions /opt/fantastixus/functions
else 
    cp -r bin /home/
    cp -r sbin /home/
    cp functions /home/functions 
fi 

echo "Initialization finished"
echo
echo "Please execute the following command as normal (non-root) user:"
echo
echo "/home/bin/dir-init"
echo 
