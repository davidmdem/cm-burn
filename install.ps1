# Powershell 5 is a dependency. Windows 10 should already have it.
if ($PSVersionTable.PSVersion.Major -lt 5) 
{
    Write-Host "PowerShell 5.0 or above is required."    
    Write-Host "See https://docs.microsoft.com/en-us/powershell/scripting/setup/installing-windows-powershell for help upgrading."    
    Exit
}

#
# Make sure that a directory exists for executable dependencies.
#
$cmBinDirectory = "~\.cloudmesh\bin"

if(-Not (Test-Path -PathType Container $cmBinDirectory)) 
{
    Write-Host "Creating $cmBinDirectory"
    New-Item -ItemType Directory -Force -Path $cmBinDirectory | Out-Null
    Write-Host "$cmBinDirectory created."
}

#
# Download and install etcher-cli.
#

# Todo: fails if bin/etcher is already installed
$etcherDownloadUrl = "https://github.com/resin-io/etcher/releases/download/v1.4.4/etcher-cli-1.4.4-windows-x64.zip"

if (-Not [Environment]::Is64BitProcess)
{
    $etcherDownloadUrl = "https://github.com/resin-io/etcher/releases/download/v1.4.4/etcher-cli-1.4.4-windows-x86.zip"
}

$etcherZip = "$env:temp\etcher-install.zip"
$etcherPath = "$cmBinDirectory\etcher" 

# PS uses a deprecated version of TLS by default.
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12

Write-Host "Downloading etcher-cli."
Invoke-WebRequest -OutFile $etcherZip $etcherDownloadUrl

Write-Host "Installing etcher-cli to $etcherPath."
Expand-Archive -Path $etcherZip -DestinationPath $etcherPath
Remove-Item -Path $etcherZip
