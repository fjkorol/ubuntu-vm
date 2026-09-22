#!/usr/bin/env bash

set -u

MONITOR_STATE=$(gdbus call \
    --session \
    --dest org.gnome.Mutter.DisplayConfig \
    --object-path /org/gnome/Mutter/DisplayConfig \
    --method org.gnome.Mutter.DisplayConfig.GetCurrentState)

CURRENT_RES=$(printf '%s\n' "$MONITOR_STATE" |
    grep -oP "[0-9]+x[0-9]+(?=@[0-9.]+', [0-9]+, [0-9]+, [^)]*'is-current')" |
    head -n1)

# Si no se pudo detectar la resolución, no hacer nada
[[ -z "$CURRENT_RES" ]] && exit 0

# Determinar escala, tamaño de cursor y tamaño de dock según resolución
case "$CURRENT_RES" in

    "1918x940"|"1918x972")
        TARGET_SCALE="1.0"
        TARGET_CURSOR=24
        TARGET_DOCK=32
        ;;

    "3838x1949"|"1928x829")
        TARGET_SCALE="1.5"
        TARGET_CURSOR=36
        TARGET_DOCK=48
        ;;

    "1918x869")
        TARGET_SCALE="2.0"
        TARGET_CURSOR=48
        TARGET_DOCK=64
        ;;

    *)
        # Resolución no contemplada
        exit 0
        ;;

esac

# Obtener escala actual
CURRENT_SCALE=$(gsettings get \
    org.gnome.desktop.interface \
    text-scaling-factor |
    tr -d "'")

# Aplicar solamente si cambió la escala
if [[ "$CURRENT_SCALE" != "$TARGET_SCALE" ]]; then
    gsettings set org.gnome.desktop.interface text-scaling-factor "$TARGET_SCALE"
    gsettings set org.gnome.desktop.interface cursor-size "$TARGET_CURSOR"
    gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size "$TARGET_DOCK"
fi