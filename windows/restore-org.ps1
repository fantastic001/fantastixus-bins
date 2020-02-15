[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $Choice = ""
)


import-module dropbox 


if ($Choice -eq "") {
    
    # New-PSDrive -Name "DropBox" -PSProvider "DropBox" 
    echo "Automatic downloading not yet available, please place your dropbox content into ~/dropbox"

    ls ~/dropbox | ? {$_.Name -match ".*\.gpg"}
    $choice = (Read-Host -Prompt "Enter your choice: ") 
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
    rm  -Force -Recurse "~/data/Documents/About Me", "~/data/Documents/Notes"
    tar -xvf backup.tar.gz 

    popd
}

unpack -Path "~/dropbox/$Choice"