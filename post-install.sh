#!/bin/bash

# Obtención del nombre de usuario del archivo preseed.cfg.
username=$(debconf-get-selections | grep passwd/username | awk '{print $NF}')

mkdir -p /home/$username/.config/autostart
touch /home/$username/.config/autostart/plank.desktop

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

# Copia el tema de GTK
cp -r /root/leopard-post-install/Leopard-linuc-theme /usr/share/themes

# Copia el tema de iconos
cp -r /root/leopard-post-install/Leopard-linux-icons /usr/share/icons

# Copia las fuentes
cp -r /root/leopard-post-install/fonts/FiraCode /usr/share/fonts/truetype
cp -r /root/leopard-post-install/fonts/SanFrancisco /usr/share/fonts/truetype

# Coopia la configuracion local del usuario
mkdir -p /home/$username/.config
cp -r /root/leopard-post-install/config/* /home/$username/.config/

# Copia los archivos locales al directorio del usuario
mkdir -p /home/$username/.local
cp -r /root/leopard-post-install/local/* /home/$username/.local

# Copia los fondos de pantalla
cp -r /root/leopard-post-install/wallpapers/* /usr/share/images/desktop-base