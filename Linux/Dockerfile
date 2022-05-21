FROM debian:bullseye-slim

# Set architecture, turn off all wine logging
ENV WINEARCH=win64
ENV WINEDEBUG=-all
# Set wine configuration directory
ENV WINEPREFIX=/root/vrising

# For the wine key
#ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1

WORKDIR /root
COPY ["./Server Files", "/root/"]
RUN chmod +x "./setup.sh" && "./setup.sh"

#COPY ["./start.ps1", "/root/start.ps1"]

#SHELL [ "pwsh", "-Command" ]

#CMD /root/start.ps1