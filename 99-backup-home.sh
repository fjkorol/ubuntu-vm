#!/bin/bash
set -e

FECHA_HORA=$(date +"%Y%m%d-%H%M%S")
BASE_DIR="/home/fer/host/datos/original/home-dirs"
DIR_UBUNTU="$BASE_DIR/ubuntu"
ORIGEN_HOME="$HOME"

echo "=== INICIANDO RESPALDO DE HOME ==="

# 1. Si existe 'ubuntu', se renombra con la fecha y hora actual
if [ -d "$DIR_UBUNTU" ]; then
    DESTINO_VIEJO="$BASE_DIR/ubuntu-$FECHA_HORA"
    echo "Renombrando '$DIR_UBUNTU' a '$DESTINO_VIEJO'..."
    mv "$DIR_UBUNTU" "$DESTINO_VIEJO"
fi

# 2. Crear la nueva carpeta 'ubuntu' vacía
mkdir -p "$DIR_UBUNTU"

# 3. Definir la lista de archivos y directorios específicos a respaldar
ITEMS=(
    ".bash_history"
    ".bash_logout"
    ".bashrc"
    ".fzf.bash"
    ".fzf.zsh"
    ".git-credentials"
    ".gitconfig"
    ".kube"
    ".p10k.zsh"
    ".p10k.zsh.bak"
    ".profile"
    ".qwen"
    ".shell.pre-oh-my-zsh"
    ".ssh"
    ".zsh_history"
    ".zshrc"
)

# 4. Filtrar solo los elementos que existen actualmente en el HOME
EXISTING_ITEMS=()
for item in "${ITEMS[@]}"; do
    if [ -e "$ORIGEN_HOME/$item" ]; then
        EXISTING_ITEMS+=("$ORIGEN_HOME/$item")
    fi
done

# 5. Copiar únicamente los elementos seleccionados
if [ ${#EXISTING_ITEMS[@]} -gt 0 ]; then
    echo "Copiando elementos seleccionados desde $ORIGEN_HOME hacia $DIR_UBUNTU..."
    rsync -av --progress "${EXISTING_ITEMS[@]}" "$DIR_UBUNTU/"
else
    echo "Advertencia: Ninguno de los elementos de la lista se encontró en $ORIGEN_HOME."
fi

echo "¡Respaldo completado con éxito en: $DIR_UBUNTU!"