#!/bin/sh

cp -r bin /home/bin/ 
cp -r sbin /home/sbin/ 
cp functions /home/functions 

echo "Initialization finished"
echo
echo "Please execute the following command as normal (non-root) user:"
echo
echo "/home/bin/dir-init"
echo 
