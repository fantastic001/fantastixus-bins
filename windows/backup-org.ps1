
pushd

cd ~/data

$TARBALL_NAME="org-backup-" + (date -UFormat "+%Y-%m-%d-%H-%M") + ".tar.gz"

tar -cvf $TARBALL_NAME "Documents/About Me/" "Documents/Finance/" "Documents/Notes"

$GPGPath = 'C:\Program Files (x86)\GNU\GnuPG\gpg2.exe' 

& $GPGPath -c $TARBALL_NAME

rclone.exe copy "$TARBALL_NAME.gpg" DropBox:/

popd