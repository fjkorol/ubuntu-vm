#!/usr/bin/env bash

set -euo pipefail

# Directorio donde está ubicado este script
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

# Archivos fuente
SCALE_SCRIPT="$SCRIPT_DIR/gnome-vmware-scale.sh"
SERVICE_FILE="$SCRIPT_DIR/gnome-vmware-scale.service"

# Directorios destino
BIN_DIR="$HOME/.local/bin"
SYSTEMD_USER_DIR="$HOME/.config/systemd/user"

# Archivos destino
SCALE_SCRIPT_DEST="$BIN_DIR/gnome-vmware-scale.sh"
SERVICE_FILE_DEST="$SYSTEMD_USER_DIR/gnome-vmware-scale.service"

echo "=============================================="
echo " GNOME VMware Scaling - Instalación"
echo "=============================================="
echo

echo "Directorio de instalación:"
echo "  $SCRIPT_DIR"
echo

# --------------------------------------------------
# Verificar archivos fuente
# --------------------------------------------------

if [[ ! -f "$SCALE_SCRIPT" ]]; then
    echo "ERROR: No existe:"
    echo "  $SCALE_SCRIPT"
    exit 1
fi

if [[ ! -f "$SERVICE_FILE" ]]; then
    echo "ERROR: No existe:"
    echo "  $SERVICE_FILE"
    exit 1
fi

# --------------------------------------------------
# Crear directorios
# --------------------------------------------------

echo "--> Creando directorios..."

mkdir -p "$BIN_DIR"
mkdir -p "$SYSTEMD_USER_DIR"

# --------------------------------------------------
# Copiar script
# --------------------------------------------------

echo "--> Instalando gnome-vmware-scale.sh..."

cp "$SCALE_SCRIPT" "$SCALE_SCRIPT_DEST"
chmod +x "$SCALE_SCRIPT_DEST"

# --------------------------------------------------
# Copiar service
# --------------------------------------------------

echo "--> Instalando gnome-vmware-scale.service..."

cp "$SERVICE_FILE" "$SERVICE_FILE_DEST"

# --------------------------------------------------
# Recargar systemd
# --------------------------------------------------

echo
echo "--> Recargando systemd user..."

systemctl --user daemon-reload

# --------------------------------------------------
# Habilitar e iniciar
# --------------------------------------------------

echo "--> Habilitando e iniciando daemon..."

systemctl --user enable --now gnome-vmware-scale.service

# --------------------------------------------------
# Verificar
# --------------------------------------------------

echo
echo "=============================================="
echo " Estado del servicio"
echo "=============================================="
echo

if systemctl --user is-active --quiet gnome-vmware-scale.service; then
    echo "✓ gnome-vmware-scale.service está ACTIVO"
else
    echo "✗ ERROR: gnome-vmware-scale.service NO está activo"
    echo
    systemctl --user status gnome-vmware-scale.service --no-pager
    exit 1
fi

echo
systemctl --user status gnome-vmware-scale.service --no-pager

echo
echo "=============================================="
echo " Instalación completada"
echo "=============================================="
echo
echo "Script:"
echo "  $SCALE_SCRIPT_DEST"
echo
echo "Service:"
echo "  $SERVICE_FILE_DEST"
echo
echo "Daemon:"
echo "  gnome-vmware-scale.service"
echo