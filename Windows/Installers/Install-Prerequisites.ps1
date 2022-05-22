$ErrorActionPreference = "Stop"

Write-Output "Installing Visual C++ 2013 redistributable"
Start-Process -FilePath "C:\GameData\Installers\vc_redist\2013\vcredist_x64.exe" -ArgumentList "/install","/quiet","/norestart" -Wait -NoNewWindow

Write-Output "Installing Visual C++ 2015+ redistributable"
Start-Process -FilePath "C:\GameData\Installers\vc_redist\2015+\VC_redist.x64.exe" -ArgumentList "/install","/quiet","/norestart" -Wait -NoNewWindow

Write-Output "Installing .NET 3.5 Runtime"
#$url = "https://download.microsoft.com/download/2/0/E/20E90413-712F-438C-988E-FDAA79A8AC3D/dotnetfx35.exe"
#New-Item -ItemType Directory -Path "C:\GameData\Installers\" -Name "DotNet3.5"
#Invoke-WebRequest $url -UseBasicParsing -OutFile "C:\GameData\Installers\DotNet3.5\dotnetfx35.exe"
Install-WindowsFeature -Name NET-Framework-Core -Source "C:\GameData\Installers\DotNet3.5" -Verbose
#Start-Process -FilePath "C:\GameData\Installers\DotNet3.5\dotnetfx35.exe" -ArgumentList "/q","/norestart" -Wait -NoNewWindow

Write-Output "Installing .NET 4.8 Runtime"
Start-Process -FilePath "C:\GameData\Installers\DotNet4.8\ndp48-web.exe" -ArgumentList "/serialdownload","/norestart","/passive" -Wait -NoNewWindow

if ($null -ne $Error[0]) {
    Write-Output $Error[0]
    return 1
}