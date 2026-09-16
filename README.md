# Ubuntu Setup

Script de instalación y configuración automatizada para sistemas Ubuntu. Este repositorio contiene una secuencia de scripts que preparan un sistema Ubuntu desde cero con software esencial, configuraciones del entorno de escritorio GNOME, herramientas de desarrollo y más.

## 📋 Requisitos previos

- Sistema Ubuntu recién instalado
- Acceso de usuario con permisos `sudo`
- Conexión a Internet

## 📁 Estructura del repositorio

```
ubuntu/
├── 1-sudo.sh              # Configura permisos sudo sin contraseña
├── 2-install_paquetes.sh  # Instala software y configura el entorno
├── 3-restore-home.sh      # Restaura directorio home desde respaldo
├── 4-setup_zsh.sh         # Configura Zsh con Oh My Zsh y Powerlevel10k
├── 5-fix_ohmyzsh-git-lenght.sh  # Ajusta límite de visualización de rama git en prompt
├── 6-tareas-opcionales.sh # Extensiones GNOME adicionales y software extra
├── 7-kubernetes-pack.sh   # Instala herramientas Kubernetes (kubectl, Helm, arkade)
├── 8-tailscale.sh         # Configura Tailscale VPN
├── 9-steam.sh             # Instala Steam para gaming
├── 99-backup-home.sh      # Crea respaldo del directorio home actual
├── virtualbox.sh          # Instala VirtualBox 7.2 con Extension Pack
└── test.sh                # Scripts de prueba y verificación
```

## 🚀 Uso

### Opción 1: Ejecutar todos los scripts en orden

Ejecuta los scripts numéricamente según su nombre:

```bash
# 1. Configurar sudo
chmod +x 1-sudo.sh
sudo ./1-sudo.sh

# 2. Instalar paquetes y configurar entorno
chmod +x 2-install_paquetes.sh
./2-install_paquetes.sh

# 3. Restaurar home (opcional, si tienes un respaldo)
chmod +x 3-restore-home.sh
./3-restore-home.sh

# 4. Configurar Zsh
chmod +x 4-setup_zsh.sh
./4-setup_zsh.sh

# 5. Corregir longitud de rama git en prompt
chmod +x 5-fix_ohmyzsh-git-lenght.sh
./5-fix_ohmyzsh-git-lenght.sh

# 6. Tareas opcionales (extensiones GNOME)
chmod +x 6-tareas-opcionales.sh
./6-tareas-opcionales.sh

# 7. Kubernetes tools
chmod +x 7-kubernetes-pack.sh
./7-kubernetes-pack.sh

# 8. Tailscale
chmod +x 8-tailscale.sh
sudo ./8-tailscale.sh

# 9. Steam
chmod +x 9-steam.sh
./9-steam.sh
```

### Opción 2: Ejecutar script de respaldo antes de empezar

Antes de ejecutar la instalación completa, crea un respaldo de tu directorio home actual:

```bash
chmod +x 99-backup-home.sh
./99-backup-home.sh
```

Esto creará un respaldo en `/home/fer/workspace/original/home-dirs/ubuntu` que puedes usar con `3-restore-home.sh` si necesitas restaurar la configuración.

### Opción 3: VirtualBox (separado)

Si necesitas VirtualBox:

```bash
chmod +x virtualbox.sh
sudo ./virtualbox.sh
```

## 📦 Lo que instala y configura

### Paquetes básicos
- Git, SSH, curl, unzip, zsh
- Herramientas de desarrollo: make, gcc, build-essential
- Utilidades: htop, mc (Midnight Commander), vlc, meld
- Gestión de paquetes: flatpak

### Entorno de escritorio GNOME
- Pantalla se apaga tras 5 minutos de inactividad
- Bloqueo automático desactivado
- Dock del sistema centrado con iconos de 40px
- Directorios personales (Documents, Downloads, etc.) redirigidos a `~/workspace/personal/`
- Configuración de usuario personalizada en `.config/user-dirs.dirs`

### Software desarrollador
- **Navegadores**: Google Chrome (stable + beta), Opera, Vivaldi, Waterfox
- **IDE**: Visual Studio Code, LM Studio (IA local)
- **Bases de datos**: PostgreSQL client, PgAdmin (Flatpak), Postman (Flatpak)
- **Contenedores**: Docker CE, Docker Compose, Tailscale VPN
- **Node.js**: Instalado vía nvm con versión 24
- **Kubernetes**: kubectl v1.36.3, Helm, arkade

### Extensiones GNOME (opcional - script 6)
- GJS OSK (teclado virtual)
- Space Bar (reordenar workspaces)
- AppIndicator support (iconos en bandeja)
- Vitals (monitoreo de sistema)

### Gaming
- Steam con soporte para arquitectura i386

## 🔧 Configuraciones específicas

### Zsh + Oh My Zsh
- Tema: Powerlevel10k
- Plugins: git, zsh-syntax-highlighting, zsh-autosuggestions, git-flow-completion
- Fuente: MesloLGS NF (instalada automáticamente)
- Configuración automática de `.zshrc`

### Docker
- Repositorio oficial configurado
- Usuario agregado al grupo `docker` para ejecutar sin sudo

### Syncthing
- Servicio habilitado para el usuario actual
- Acceso web en http://localhost:8384

## 📝 Notas importantes

1. **Script 1-sudo.sh**: Requiere ejecutarse con `sudo` y añade una regla NOPASSWD para el usuario `fer`
2. **Script 2-install_paquetes.sh**: Realiza actualizaciones del sistema y puede tardar varios minutos
3. **Directorios personales**: Se redirigen a `~/workspace/personal/` - asegúrate de tener este directorio o ajustar las rutas
4. **Reinicios necesarios**: Algunas configuraciones (como grupo docker o vboxusers) requieren cerrar sesión y volver a iniciar

## 🛠️ Personalización

Para adaptar estos scripts a tu usuario:

1. Reemplaza `fer` por tu nombre de usuario en:
   - `1-sudo.sh`: línea 10
   - `3-restore-home.sh`, `99-backup-home.sh`: directorios base
   - `2-install_paquetes.sh`: git config email y name

2. Ajusta las rutas en `personal/.config/user-dirs.dirs` si usas una estructura diferente

## 🐛 Solución de problemas

- Si falla la instalación de fuentes, ejecuta: `fc-cache -f`
- Para reiniciar configuraciones GNOME sin reiniciar: `pkill gnome-shell`
- Verificar estado de Docker: `docker info` y `docker ps`

## 📄 Licencia

Este repositorio es de código abierto y está disponible bajo la licencia MIT.
