[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $Choice = ""
)



if ($Choice -eq "") {
    
    rclone.exe ls DropBox:/ 
    $choice = (Read-Host -Prompt "Enter name of your backup: ") 
    echo "Downloading $choice ...."
    rclone copy DropBox:/$choice (Get-Item ~/data/).FullName
}

function unpack {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string]
        $Path
    )

    mkdir -Force "~/data"
    pushd 
    cd "~/data"

    $GPGPath = 'C:\Program Files (x86)\GNU\GnuPG\gpg2.exe' 
    if (test-path "backup.tar.gz") 
    {
        rm backup.tar.gz
    }
    $Path = (Get-Item $Path).FullName
    & $GPGPath -o backup.tar.gz -d $Path
    try {
        rm  -Force -Recurse "~/data/Documents/About Me", "~/data/Documents/Notes"
    } catch {
        echo "Directories not removed....skipping"
    }
    tar -xvf backup.tar.gz 

    popd
}

unpack -Path "~/data/$Choice"