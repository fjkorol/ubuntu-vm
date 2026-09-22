[Unit]
Description=GNOME VMware automatic text scaling
After=graphical-session.target

[Service]
Type=simple
ExecStart=%h/.local/bin/gnome-vmware-scale-daemon.sh
Restart=always
RestartSec=1

[Install]
WantedBy=default.target