# Quit on any errors
$ErrorActionPreference = "Stop"

Write-Output "`n"
Write-Output "\\\\\ Starting Container //////`n"

Write-Output "- Running in $(Get-Location)`n"

Write-Output "\\\\\\\ Updating Server ///////`n"

if (-not (Test-Path "/root/GameData")) {
    throw "Unable to find '/root/GameData'. Have you mounted your volumes correctly?"
}

if (-not (Test-Path "/root/GameData/Steam/steamcmd")) {

}