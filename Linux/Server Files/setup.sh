# Prep repos
dpkg --add-architecture i386
apt update -qq && apt upgrade -qq -y

# Install PowerShell
# Install system components
apt install -y curl gnupg apt-transport-https
# Import the public repository GPG keys
curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-debian-bullseye-prod bullseye main" > /etc/apt/sources.list.d/microsoft.list'
# Install PowerShell
apt update
apt install -y -qq powershell 

# Install Wine
apt install -y -qq wine wget unzip xvfb
#mkdir -p /root/.wine/drive_c/steamcmd
#mkdir -p /root/.wine/drive_c/users/root/AppData/LocalLow/'Stunlock Studios'/VRisingServer/Settings
#wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd.zip -P /root/Steam
#cd /root/Steam
#unzip steamcmd.zip

# Install Steam
# Create a new sources.list, then append to it
sh -c 'echo "deb http://deb.debian.org/debian/ bullseye main non-free contrib" > /etc/apt/sources.list'
sh -c 'echo "deb http://security.debian.org/debian-security bullseye-security main non-free contrib" >> /etc/apt/sources.list'
sh -c 'echo "deb http://deb.debian.org/debian/ bullseye-updates main non-free contrib" >> /etc/apt/sources.list'

sh -c 'echo steam steam/question select "I AGREE" | debconf-set-selections'
sh -c 'echo steam steam/license note "" | debconf-set-selections'
apt update
apt install -y -qq lib32gcc-s1 steamcmd

# Remove stuff we do not need anymore to reduce docker size
apt remove curl -qq -y
apt autoremove -qq -y
apt clean autoclean -qq
rm -rf /var/lib/{apt,dpkg,cache,log}/