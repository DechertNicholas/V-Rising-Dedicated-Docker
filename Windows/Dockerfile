ARG LTSC
FROM $LTSC 
# mcr.microsoft.com/windows/servercore:ltsc2019

SHELL [ "PowerShell.exe", "-Command" ]
COPY ".\\Installers" "C:\\GameData\\Installers"
RUN "C:\GameData\Installers\Install-Prerequisites.ps1"

COPY ".\\Start.ps1" "C:\\GameData\\"
WORKDIR "C:\GameData"

CMD C:\GameData\Start.ps1