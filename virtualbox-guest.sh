#!/bin/bash

# Salir inmediatamente si ocurre un error
set -e

sudo apt update && sudo apt upgrade -y
sudo apt install build-essential dkms linux-headers-$(uname -r) -y

#montar y posicionarse sobre disco guest additions
#sudo ./VBoxLinuxAdditions.run
