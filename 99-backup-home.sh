#!/bin/bash
set -e

FECHA_HORA=$(date +"%Y%m%d-%H%M%S")
BASE_DIR="/home/fer/workspace/original/home-dirs"
DIR_UBUNTU="$BASE_DIR/ubuntu"
ORIGEN_HOME="$HOME/"

echo "=== INICIANDO RESPALDO DE HOME ==="

# 1. Si existe 'ubuntu', se renombra con la fecha y hora actual
if [ -d "$DIR_UBUNTU" ]; then
    DESTINO_VIEJO="$BASE_DIR/ubuntu-$FECHA_HORA"
    echo "Renombrando '$DIR_UBUNTU' a '$DESTINO_VIEJO'..."
    mv "$DIR_UBUNTU" "$DESTINO_VIEJO"
fi

# 2. Crear la nueva carpeta 'ubuntu' vacía
mkdir -p "$DIR_UBUNTU"

# 3. Copiar el HOME actual hacia 'ubuntu'
echo "Copiando $ORIGEN_HOME hacia $DIR_UBUNTU..."
rsync -av --progress \
    --exclude='.cache' \
    --exclude='.local/share/Trash' \
    "$ORIGEN_HOME" "$DIR_UBUNTU/"

echo "¡Respaldo completado con éxito en: $DIR_UBUNTU!"
