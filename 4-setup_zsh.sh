#!/usr/bin/env bash

set -e

echo "---- Instalando dependencias (Ubuntu) ----"

sudo apt update
sudo apt install -y \
    zsh \
    git \
    curl \
    fzf \
    fontconfig
    
#VER ESTO FALLABA    sudo apt-get install -y fontconfig fonts-powerline

echo "---- Dependencias instaladas ----"

# Cambiar shell a zsh si no lo es
if [[ "$SHELL" != *"zsh" ]]; then
    echo "--- Cambiando shell por defecto a zsh ---"
    chsh -s $(which zsh)
fi


# 1. Instalar fuentes MesloLGS NF
FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"

echo "--- Instalando fuentes MesloLGS NF ---"

fonts=("Regular" "Bold" "Italic" "Bold%20Italic")

for style in "${fonts[@]}"; do
    file_name="MesloLGS%20NF%20$style.ttf"
    clean_name=$(echo $file_name | sed 's/%20/ /g')

    if [ ! -f "$FONT_DIR/$clean_name" ]; then
        curl -L -o "$FONT_DIR/$clean_name" \
        "https://github.com/romkatv/powerlevel10k-media/raw/master/$file_name"
    fi
done

fc-cache -f


# 2. Instalar Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "--- Instalando Oh My Zsh ---"
    KEEP_ZSHRC=yes RUNZSH=no \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
    --unattended
fi


ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}


# 3. Plugins y Powerlevel10k
echo "--- Descargando plugins ---"

declare -A addons=(
["plugins/zsh-syntax-highlighting"]="https://github.com/zsh-users/zsh-syntax-highlighting.git"
["plugins/zsh-autosuggestions"]="https://github.com/zsh-users/zsh-autosuggestions"
["plugins/git-flow-completion"]="https://github.com/bobthecow/git-flow-completion"
["themes/powerlevel10k"]="https://github.com/romkatv/powerlevel10k.git"
)

for path in "${!addons[@]}"; do
    if [ ! -d "$ZSH_CUSTOM/$path" ]; then
        git clone --depth=1 "${addons[$path]}" "$ZSH_CUSTOM/$path"
    fi
done

# --- NUEVA SECCIÓN: Instalación avanzada de fzf ---
if [ ! -d "$HOME/.fzf" ]; then
    echo "--- Configurando fzf desde repositorio ---"
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install --all
fi


# 4. Configuración de .zshrc
echo "--- Configurando .zshrc ---"

touch ~/.zshrc

sed -i 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc || true

if grep -q "plugins=(" ~/.zshrc; then
    sed -i 's/plugins=(.*)/plugins=(git zsh-syntax-highlighting zsh-autosuggestions git-flow-completion)/' ~/.zshrc
else
    echo 'plugins=(git zsh-syntax-highlighting zsh-autosuggestions git-flow-completion)' >> ~/.zshrc
fi


echo
echo "---- Instalación completada ----"
echo "Reinicia la terminal y ejecuta:"
echo "p10k configure"
echo
echo "Configura tu terminal para usar la fuente:"
echo "MesloLGS NF"


#Backup configuración ptyxis
#dconf dump /org/gnome/Ptyxis/ > ptyxis_backup.ini

#Restaurar configuración ptyxis
dconf load /org/gnome/Ptyxis/ < ptyxis_backup.ini
