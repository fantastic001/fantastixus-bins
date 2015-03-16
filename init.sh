#!/bin/sh

cp -r bin /home/
cp -r sbin /home/
cp functions /home/functions 

echo "Initialization finished"
echo
echo "Please execute the following command as normal (non-root) user:"
echo
echo "/home/bin/dir-init"
echo 
