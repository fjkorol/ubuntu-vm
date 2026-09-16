#!/bin/bash
set -e

DIR_UBUNTU="/home/fer/workspace/original/home-dirs/ubuntu"
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
