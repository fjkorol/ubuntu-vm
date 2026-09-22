#!/bin/bash
set -e

DIR_UBUNTU="/home/fer/host/datos/original/home-dirs/ubuntu"
DESTINO_HOME="$HOME/"

# Verificar que exista el directorio
if [ ! -d "$DIR_UBUNTU" ]; then
    echo "Error: No existe el directorio $DIR_UBUNTU"
    exit 1
fi

echo "=== RESTAURACIÓN DE HOME ==="
echo "Origen: $DIR_UBUNTU/"
echo "Destino: $DESTINO_HOME"
echo ""
rsync -av --progress "$DIR_UBUNTU/" "$DESTINO_HOME"

echo "Permisos a .kube y .ssh"

chmod 700 ~/.ssh
chmod 600 ~/.ssh/*

chmod 700 ~/.kube
chmod 600 ~/.kube/*

echo "¡Restauración completada con éxito!"




# read -p "¿Estás seguro de que deseas sobrescribir los archivos de tu HOME? (s/N): " CONFIRMACION

# if [[ "$CONFIRMACION" =~ ^[Ss]$ ]]; then
#     echo "Restaurando archivos..."
#     rsync -av --progress "$DIR_UBUNTU/" "$DESTINO_HOME"
#     echo "¡Restauración completada con éxito!"
# else
#     echo "Restauración cancelada."
# fi





#Redirección de los directorios personales a workspace/personal


#mover dir personal a workspace

rm -rf "$HOME/Documents"
rm -rf "$HOME/Downloads"
rm -rf "$HOME/Pictures"
rm -rf "$HOME/Videos"
rm -rf "$HOME/Music"
rm -rf "$HOME/Templates"
rm -rf "$HOME/Public"
rm -rf "$HOME/Desktop"


ln -s "$HOME/host/datos/personal/Documents" "$HOME/Documents"
ln -s "$HOME/host/datos/personal/Downloads" "$HOME/Downloads"
ln -s "$HOME/host/datos/personal/Pictures" "$HOME/Pictures"
ln -s "$HOME/host/datos/personal/Videos" "$HOME/Videos"
ln -s "$HOME/host/datos/personal/Music" "$HOME/Music"
ln -s "$HOME/host/datos/personal/Templates" "$HOME/Templates"
ln -s "$HOME/host/datos/personal/Public" "$HOME/Public"
ln -s "$HOME/host/datos/personal/Desktop" "$HOME/Desktop"


# Definir variables de ruta
ORIGEN="$HOME/host/datos/github/kubuntu-vm/personal/.config/user-dirs.dirs"
DESTINO="$HOME/.config/user-dirs.dirs"

# Comprobar si el archivo de origen existe
if [ -f "$ORIGEN" ]; then
    # Crear el directorio de destino si no existe
    mkdir -p "$HOME/.config"
    
    # Copiar y reemplazar el archivo
    cp "$ORIGEN" "$DESTINO"
    echo "Archivo copiado y reemplazado con éxito en $DESTINO"
else
    echo "Error: El archivo de origen no existe en $ORIGEN"
fi

xdg-user-dirs-update
