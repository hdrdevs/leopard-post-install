#!/bin/bash

# Obtención del nombre de usuario del archivo preseed.cfg.
username=$(debconf-get-selections | grep passwd/username | awk '{print $NF}')

# Configuración para agregar Docky al inicio de la sesión del usuario.
cat <<EOF > /home/$username/.config/autostart/plank.desktop
[Desktop Entry]
Type=Application
Name=Plank
Exec=plank
NoDisplay=false
Hidden=false
X-GNOME-Autostart-enabled=true
EOF

# Configuración de permisos para el archivo de inicio de sesión.
chown $username:$username /home/$username/.config/autostart/plank.desktop
chmod +x /home/$username/.config/autostart/plank.desktop
