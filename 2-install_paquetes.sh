#!/bin/bash
set -e

#habilitar pegar click central
gsettings set org.gnome.desktop.interface gtk-enable-primary-paste true


#actualizacion inicial
sudo apt update -y && sudo apt upgrade -y

# Add Docker's official GPG key:
# Definir modo no interactivo para apt
export DEBIAN_FRONTEND=noninteractive

#paquetes basicos:
sudo apt-get install -y git ssh curl unzip zsh p7zip-full make gcc rar unrar powerstat build-essential pkg-config






echo "Aplicando configuración de pantalla y bloqueo..."

# 1. Apagar pantalla a los 5 minutos (300 segundos)
gsettings set org.gnome.desktop.session idle-delay 300

# 2. Desactivar el bloqueo automático de pantalla
gsettings set org.gnome.desktop.screensaver lock-enabled false

# 3. Retardo de bloqueo en 0 (Al apagarse la pantalla)
gsettings set org.gnome.desktop.screensaver lock-delay 0

# 4. Ocultar notificaciones en la pantalla de bloqueo
gsettings set org.gnome.desktop.notifications show-in-lock-screen false

# 5. Desactivar el bloqueo de pantalla al suspender el equipo
gsettings set org.gnome.desktop.screensaver ubuntu-lock-on-suspend false

echo "¡Configuración aplicada con éxito!"


echo "Configurando Ubuntu Dock en el centro..."

# 1. Centrar el Dock (Desactivar modo panel / extender a bordes)
gsettings set org.gnome.shell.extensions.dash-to-dock always-center-icons true



# 3. Tamaño de iconos a 40px
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 40

# 4. Posición abajo y en todos los monitores
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'
gsettings set org.gnome.shell.extensions.dash-to-dock multi-monitor true

# 5. Ocultar dispositivos montados, de red y papelera
gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts false
gsettings set org.gnome.shell.extensions.dash-to-dock show-trash false

# 6.Ocultar monitor y workspace para app
gsettings set org.gnome.shell.extensions.dash-to-dock isolate-monitors true
gsettings set org.gnome.shell.extensions.dash-to-dock isolate-workspaces true

echo "¡Dock centrado y configurado correctamente!"






# 1. Navegadores, VS Code y LM Studio
echo "--> Instalando Google Chrome, Opera, Visual Studio Code y LM Studio..."


# -----------------------------------------------------------------------------
# Google Chrome
# -----------------------------------------------------------------------------
if [ ! -f /etc/apt/sources.list.d/google-chrome.list ]; then
    curl -fsSL https://dl.google.com/linux/linux_signing_key.pub \
        | sudo gpg --dearmor -o /usr/share/keyrings/google-chrome.gpg

    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] https://dl.google.com/linux/chrome/deb/ stable main" \
        | sudo tee /etc/apt/sources.list.d/google-chrome.list >/dev/null
fi

# -----------------------------------------------------------------------------
# Visual Studio Code
# -----------------------------------------------------------------------------
if [ ! -f /etc/apt/sources.list.d/vscode.list ]; then
    curl -fsSL https://packages.microsoft.com/keys/microsoft.asc \
        | sudo gpg --dearmor -o /usr/share/keyrings/microsoft.gpg

    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/code stable main" \
        | sudo tee /etc/apt/sources.list.d/vscode.list >/dev/null
fi

# -----------------------------------------------------------------------------
# Opera
# -----------------------------------------------------------------------------
if [ ! -f /etc/apt/sources.list.d/opera-stable.list ]; then
    curl -fsSL https://deb.opera.com/archive.key \
        | sudo gpg --dearmor -o /usr/share/keyrings/opera.gpg

    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/opera.gpg] https://deb.opera.com/opera-stable/ stable non-free" \
        | sudo tee /etc/apt/sources.list.d/opera-stable.list >/dev/null
fi

# -----------------------------------------------------------------------------
# Actualizar repositorios
# -----------------------------------------------------------------------------
sudo apt update -y



# -----------------------------------------------------------------------------
# Instalar paquetes
# -----------------------------------------------------------------------------
sudo apt install -y \
    google-chrome-stable \
    google-chrome-beta \
    code \
    opera-stable



#paquetes complementarios:
sudo apt-get install -y postgresql-client meld git-flow gnome-shell-extensions chrome-gnome-shell geany mc  htop nmap gnome-tweaks gnome-system-monitor stress libfuse2 fzf flatpak direnv pipx






echo "paquetes flatpak"

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install -y flathub \
com.getpostman.Postman \
org.pgadmin.pgadmin4 \
net.waterfox.waterfox



git config --global credential.helper store
git config --global core.editor "nano"
git config --global user.email "ferkorol@gmail.com"
git config --global user.name "Fernando Korol"




echo "Instalacion DOCKER"

sudo apt update -y
sudo apt install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Agregar el repositorio a las fuentes de Apt:
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF

sudo apt update -y

sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo gpasswd -a $USER docker




#EXTENSIONES de GNOME
# OSK keyboard virtual GNOME:
# https://extensions.gnome.org/extension/5949/gjs-osk/

# reorder workspace
# https://extensions.gnome.org/extension/5090/space-bar/

# tray icon
# https://extensions.gnome.org/extension/615/appindicator-support/ 


pipx ensurepath
pipx install gnome-extensions-cli


#eliminar archivos macOS
#find ~/workspace \( -name '.DS_Store' -o -name '._*' -o -name '.Spotlight-V100' -o -name '.Trashes' -o -name '.fseventsd' -o -name '.AppleDouble' -o -name '.AppleDB' -o -name '.AppleDesktop' \) -exec rm -rf {} +


#Freelens
curl -L https://raw.githubusercontent.com/freelensapp/freelens/refs/heads/main/freelens/build/apt/freelens.asc | sudo tee /etc/apt/keyrings/freelens.asc
curl -L https://raw.githubusercontent.com/freelensapp/freelens/refs/heads/main/freelens/build/apt/freelens.sources | sudo tee /etc/apt/sources.list.d/freelens.sources
sudo apt update
sudo apt install freelens




#Revisar y actualizar periodicamente NODE
#https://nodejs.org/en/download

# Download and install nvm:
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.6/install.sh | bash
# in lieu of restarting the shell
\. "$HOME/.nvm/nvm.sh"
# Download and install Node.js:
nvm install 24
# Verify the Node.js version:
node -v # Should print "v24.19.0".
# Verify npm version:
npm -v # Should print "11.17.0".


#qwen code terminal
curl -fsSL https://qwen-code-assets.oss-cn-hangzhou.aliyuncs.com/installation/install-qwen-standalone.sh | bash




#Syncthing INI
# Añadir la clave GPG oficial de Syncthing
sudo mkdir -p /etc/apt/keyrings
sudo curl -L -o /etc/apt/keyrings/syncthing-archive-keyring.gpg https://syncthing.net/release-key.gpg

# Agregar el repositorio estable
echo "deb [signed-by=/etc/apt/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list

# Actualizar e instalar
sudo apt update
sudo apt install syncthing -y

# Habilitar el servicio para tu usuario actual
systemctl --user enable syncthing.service
systemctl --user start syncthing.service

#syncthing web
#http://localhost:8384
#Syncthing FIN


echo "--> Instalando Tailscale..."
curl -fsSL https://tailscale.com/install.sh | sh
