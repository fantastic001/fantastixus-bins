
function Install-GnuPg 
{ 
    <# 
    .SYNOPSIS 
        This function installed the GnuPg for Windows application.  It the installer file is not in 
        the DownloadFolderPath, the function will download the file from the Internet and then execute a silent installation. 
    .PARAMETER  DownloadFolderPath 
        The folder path where you'd like to download the GnuPg for Windows installer into. 
 
    .PARAMETER  DownloadUrl 
        The URL that will be used to download the EXE setup installer. 
 
    .EXAMPLE 
        PS> Install-GnuPg -DownloadFolderPath C:\Downloads 
 
        This will first check to ensure the GnuPg for Windows installer is in the C:\Downloads folder.  If not, it will then 
        download the file from the default URL set at DownloadUrl.  Once downloaded, it will then silently execute 
        the installation and get the application installed with default parameters. 
     
    .INPUTS 
        None. This function does not accept pipeline input. 
 
    .OUTPUTS 
        None. If successful, this function will not return any output. 
    #> 
     
    [CmdletBinding()] 
    param 
    ( 
        [Parameter(Mandatory)] 
        [ValidateNotNullOrEmpty()] 
        [string]$DownloadFolderPath, 
         
        [Parameter()] 
        [ValidateNotNullOrEmpty()] 
        [string]$DownloadUrl = 'http://files.gpg4win.org/gpg4win-2.2.5.exe' 
         
    ) 
    process 
    { 
        try 
        { 
            $DownloadFilePath = "$DownloadFolderPath\$($DownloadUrl | Split-Path -Leaf)" 
            if (-not (Test-Path -Path $DownloadFilePath -PathType Leaf)) 
            { 
                Write-host "Downloading [$($DownloadUrl)] to [$($DownloadFilePath)]" 
                Invoke-WebRequest -Uri $DownloadUrl -OutFile $DownloadFilePath 
            } 
            else 
            { 
                Write-host "The download file [$($DownloadFilePath)] already exists" 
            } 
            Write-host "Attempting to install GPG4Win from $DownloadFilePath ..." 
            Start-Process -Verb runas -FilePath (Get-Item "$DownloadFilePath").FullName -ArgumentList '/S' -Wait -PassThru 
            Write-host 'GPG4Win installed' 
        } 
        catch 
        { 
            Write-Error $_.Exception.Message 
        } 
    } 
} 

mkdir -Force -Path ~/Downloads/GnuPG

Install-GnuPg -DownloadFolderPath "~/Downloads/GnuPG"
