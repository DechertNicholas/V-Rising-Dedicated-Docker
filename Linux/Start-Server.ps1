# Quit on any errors
$ErrorActionPreference = "Stop"
$env:SteamAppId="1604030"

Write-Output "`n"
Write-Output "\\\\\ Starting Container //////`n"

Write-Output "- Running in $(Get-Location)`n"

Write-Output "\\\\\\\ Updating Server ///////`n"

if (-not (Test-Path "/root/GameData")) {
    throw "Unable to find '/root/GameData'. Have you mounted your volumes correctly?"
}

if (-not (Test-Path "/root/GameData/Steam")) {
    Write-Output "Steam data directory not found - creating directory"
    mkdir /root/GameData/Steam
}

if (-not (Test-Path "/root/Steam")) {
    Write-Output "Local link for Steam data not created - creating link"
    ln -s /root/GameData/Steam /root/Steam
}

if ((Get-Item /root/Steam/).LinkType -ne "SymbolicLink") {
    throw "Unable to create symbolic link from /root/Steam to /root/GameData/Steam. Investigate this container"
} elseif ((Get-Item /root/Steam/).LinkType -eq "SymbolicLink") {
    Write-Output "Link created"
}

/usr/games/steamcmd +login anonymous +@sSteamCmdForcePlatformType windows +app_update 1829350 validate +quit

Write-Output "`n"
Write-Output "\\\\\\\ Starting Server ///////`n"
Set-Location /root/GameData/Steam/steamapps/common/VRisingDedicatedServer

# For whatever reason, I cannot get the server to respect the adminlist in the save folder
# So, we'll delete the one it wants to reference, and symlink it with the one we want it to use

$defaultAdminPath = "/root/GameData/Steam/steamapps/common/VRisingDedicatedServer/VRisingServer_Data/StreamingAssets/Settings/adminlist.txt"
if ((Get-Item $defaultAdminPath).LinkType -ne "SymbolicLink") {
    $target = Get-Item "/root/GameData/SaveData/Saves/v1/$($env:WORLDNAME)/adminlist.txt"
    Remove-Item $defaultAdminPath | Out-Null
    New-Item -ItemType SymbolicLink -Path $defaultAdminPath -Target $target.FullName | Out-Null
}

# Startup command from https://github.com/Googlrr/V-Rising-Docker-Linux/blob/main/root/scripts/run.sh
# X session will remain after the container goes down, so delete it for next startup
Remove-Item /tmp/.X0-lock -ErrorAction SilentlyContinue

Start-Job -ScriptBlock {Xvfb :0 -screen 0 1024x768x16} | Out-Null
$env:DISPLAY=":0.0"
wine VRisingServer.exe -persistentDataPath "Z:/root/GameData/SaveData" -saveName $env:WORLDNAME