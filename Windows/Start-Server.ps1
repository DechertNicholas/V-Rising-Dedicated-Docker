$env:SteamAppId="1604030"
Write-Output "Starting V Rising Dedicated Server - PRESS CTRL-C to exit"

.\VRisingServer.exe -persistentDataPath .\save-data -serverName "My V Rising Server" -saveName "world1" -logFile ".\logs\VRisingServer.log"
