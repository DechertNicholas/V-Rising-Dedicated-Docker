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

COPY ["./Start-Server.ps1", "/root/Start-Server.ps1"]

EXPOSE 9876/udp
EXPOSE 9877/udp
EXPOSE 27015/udp
EXPOSE 27016/udp

SHELL [ "pwsh", "-Command" ]
CMD /root/Start-Server.ps1