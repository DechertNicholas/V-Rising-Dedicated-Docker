# Space Engineers Dedicated Server Docker Windows
A docker image for Space Engineers Dedicated Server, running on native Windows Server

[![Docker Image CI](https://github.com/DechertNicholas/SpaceEngineers-Dedicated-Server-Docker-Windows/actions/workflows/docker-image.yml/badge.svg?branch=main)](https://github.com/DechertNicholas/SpaceEngineers-Dedicated-Server-Docker-Windows/actions/workflows/docker-image.yml)
![Docker Hub Pulls](https://img.shields.io/docker/pulls/dechertnicholas/space-engineers-ds-windows)

# Docker Hub
Link for Docker Hub: https://hub.docker.com/r/dechertnicholas/space-engineers-ds-windows

# Acknowledgements
A special thanks to [Devidian](https://github.com/Devidian) for their continued work on a 
[Linux docker image](https://github.com/Devidian/docker-spaceengineers) which was used as a base for this Windows image, as well as [7thCore](https://github.com/7thCore) and [mmmaxwwwell](https://github.com/mmmaxwwwell).

# A reason for Windows
While a couple images exist for Space Engineers Dedicated Server running under Linux/Wine, I've always preferred running under a native OS when possible. I also seem to have continuous issues with Wine, and a few possible performance issues - and so this image was born.

# Instructions
1. Download the Space Engineers Dedicated Server Tool as described below, and follow the instructions to setup a new world:  
https://www.spaceengineersgame.com/dedicated-servers/

1. Be sure to **save and start** the server after you configure it! Some other files are generated/edited on **start** that are not on **save**  
This manual step is needed as the Dedicated Server Tool is not able to make new worlds by command line yet.

1. Create the `Instances` and `Steam` folders in the directory you would like to run the server in. Steamcmd and the game files will be stored in `Steam`, while your world will be stored in `Instances`

1. Copy the world folder to the `Instances` folder. By default the Space Engineers Dedicated Server Tool saves new worlds in `C:\ProgramData\SpaceEngineersDedicated\{YourWorld}`.  
Ex. `Copy-Item C:\ProgramData\SpaceEngineersDedicated\$YourWorld D:\Path\To\Instances\$YourWorld -Recurse`

1. Download the image and start your container. An example docker-compose.yml is posted below. Check the file in the repository for the latest updates, as this readme version may not always be up to date:
```yaml
version: "3.8"

services:
  SpaceEngineersDedicatedServer:
    image: dechertnicholas/space-engineers-ds-windows:ltsc2022
    container_name: "SpaceEngineersDedicatedServer"
    build: .
    restart: unless-stopped
    ports:
      # YourMachine:27016 (don't change 27016)
      - 27016:27016/udp
      # VRage Remote API
      - 8080:8080/tcp
    environment:
      # The name of your server folder
      - INSTANCENAME=DockerTest
      # Should steam be installed if it can't be found, useful on first run
      # Be sure to mount your steam folder below, otherwise steam will download each time
      - INSTALLSTEAM=TRUE
    volumes:
      # YourMachine:DockerContainer
      # Be sure to create the folders for YourMachine, or you'll get an error
      - ./Steam:C:/GameData/Steam
      - ./Instances:C:/GameData/Instances
```