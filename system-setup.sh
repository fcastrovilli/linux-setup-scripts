#!/bin/bash

# ---------------------------
# This is a bash script for configuring Ubuntu 22.04 (jammy).
# ---------------------------
#
# STEP 1: Run this command to configure your system audio setup with wine and winetricks:
# wget -O ~/install-audio.sh https://raw.githubusercontent.com/brendaningram/linux-audio-setup-scripts/main/ubuntu/2204/install-audio.sh && chmod +x ~/install-audio.sh && ~/install-audio.sh
#
# STEP 2: Run this command to execute this script:
# wget -O ~/system-setup.sh https://raw.githubusercontent.com/fcastrovilli/linux-setup-scripts/main/system-setup.sh && chmod +x ~/system-setup.sh && ~/system-setup.sh


# Exit if any command fails
set -e

notify () {
  echo "--------------------------------------------------------------------"
  echo $1
  echo "--------------------------------------------------------------------"
}

# ---------------------------
# Generic
# ---------------------------
notify "Update and Install generic deps"
sudo apt update && sudo apt dist-upgrade -y
sudo apt install git curl wget gpg gnome-sushi gnome-tweaks make -y
sudo apt autoremove -y

# ---------------------------
# GUI
# ---------------------------
notify "Updating GUI Settings"
gsettings set org.gnome.desktop.background picture-options 'none'
gsettings set org.gnome.desktop.background primary-color '#000000'

cat <<EOF >~/gui-setting.ini
[org/gnome/desktop/interface]
color-scheme='prefer-dark'
font-hinting='slight'
gtk-theme='Yaru-magenta-dark'
icon-theme='Yaru-magenta'

[org/gnome/shell/extensions/dash-to-dock]
dash-max-icon-size=48
dock-fixed=false
dock-position='BOTTOM'
extend-height=false
multi-monitor=true
EOF

dconf load / < ~/gui-setting.ini

# ---------------------------
# OhMyZSH
# ---------------------------
notify "ZSH & OhMyZSH"
sudo apt install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# ---------------------------
# SSH
# ---------------------------
notify "SSH"
ssh-keygen -t ed25519 -C "$(hostname)"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# ---------------------------
# VSCode
# ---------------------------
notify "VSCode"
sudo snap install --classic code

# ---------------------------
# GitHub Desktop
# ---------------------------
notify "GitHub Desktop"
cd ~/Downloads
wget https://github.com/shiftkey/desktop/releases/download/release-3.3.3-linux2/GitHubDesktop-linux-amd64-3.3.3-linux2.deb
sudo dpkg -i GitHubDesktop-linux-amd64-3.3.3-linux2.deb
sudo rm GitHubDesktop-linux-amd64-3.3.3-linux2.deb

# ---------------------------
# Obsidian
# ---------------------------
notify "Obsidian"
cd ~/Downloads
wget https://github.com/obsidianmd/obsidian-releases/releases/download/v1.4.16/obsidian_1.4.16_amd64.deb
sudo dpkg -i obsidian_1.4.16_amd64.deb
sudo rm obsidian_1.4.16_amd64.deb

# ---------------------------
# Telegram
# ---------------------------
notify "Telegram"
sudo snap install telegram-desktop

# ---------------------------
# Chrome
# ---------------------------
notify "Google Chrome"
cd ~/Downloads 
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo rm google-chrome-stable_current_amd64.deb

# ---------------------------
# VLC
# ---------------------------
notify "VLC"
sudo snap install vlc

# ---------------------------
# QBitTorrent
# ---------------------------
notify "QBitTorrent"
sudo add-apt-repository ppa:qbittorrent-team/qbittorrent-stable -y
sudo apt update
sudo apt install qbittorrent -y

# ---------------------------
# Ableton 11
# ---------------------------
notify "Ableton 11"
cd ~/Downloads
wget https://cdn-downloads.ableton.com/channels/11.1.5/ableton_live_suite_11.1.5_64.zip -O ./ableton.zip
mkdir ./ableton11_installer
unzip ableton.zip -d ./ableton11_installer
cd ./ableton11_installer
wine64 Ableton\ Live\ 11\ Suite\ Installer.exe
cd ..
rm -rf ./ableton11_installer/
rm ableton.zip

# ---------------------------
# Ulauncher
# ---------------------------
notify "Ulauncher"
sudo add-apt-repository universe -y && sudo add-apt-repository ppa:agornostal/ulauncher -y && sudo apt update && sudo apt install ulauncher -y

# ---------------------------
# Docker
# ---------------------------
notify "Docker"
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo usermod -aG docker $USER

# ---------------------------
# Cleanup
# ---------------------------
notify "Cleanup"
sudo apt autoremove -y
sudo apt-get autoclean -y
