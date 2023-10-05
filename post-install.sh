#!/bin/bash

# Obtención del nombre de usuario del archivo preseed.cfg.
username=$(debconf-get-selections | grep passwd/username | awk '{print $NF}')

mkdir -p /home/$username/.config/autostart
touch /home/$username/.config/autostart/plank.desktop

# Configuración de permisos para el archivo de inicio de sesión.
chown $username:$username /home/$username/.config/autostart/plank.desktop
chmod +x /home/$username/.config/autostart/plank.desktop

# Copia el tema de Plank
cp -r /root/leopard-post-install/cratos-lion /usr/share/plank/themes

# Copia el tema de GTK
cp -r /root/leopard-post-install/Leopard-linux-theme /usr/share/themes

# Copia los launchers de las aplicaciones
cp -r /root/leopard-post-install/applications/rofi.desktop /usr/share/applications

# Copia el tema de iconos
cp -r /root/leopard-post-install/Leopard-linux-icons /usr/share/icons

# Copia las fuentes
cp -r /root/leopard-post-install/fonts/FiraCode /usr/share/fonts/truetype
cp -r /root/leopard-post-install/fonts/SanFrancisco /usr/share/fonts/truetype

# Coopia la configuracion local del usuario
mkdir -p /home/$username/.config
cp -r /root/leopard-post-install/config/* /home/$username/.config/
chown -R $username:$username /home/$username/.config

# Copia los archivos locales al directorio del usuario
mkdir -p /home/$username/.local
cp -r /root/leopard-post-install/local/* /home/$username/.local
chown -R $username:$username /home/$username/.local

# Copia los fondos de pantalla
cp -r /root/leopard-post-install/wallpapers/* /usr/share/images/desktop-base

# Crea la configuracion del escritorio
mkdir -p /home/$username/.config/xfce4/desktop
touch /home/$username/.config/xfce4/desktop/icons.screen.latest.rc
cat <<EOF > /home/$username/.config/xfce4/desktop/icons.screen.latest.rc
[xfdesktop-version-4.10.3+-rcfile_format]
4.10.3+=true

[Trash]
row=0
col=0

[/home/$username]
row=1
col=0
EOF
chown $username:$username /home/$username/.config/xfce4/desktop/icons.screen.latest.rc

# Rofi theme
mkdir -p /home/$username/.config/rofi
touch /home/$username/.config/rofi/config.rasi
cat <<EOF > /home/$username/.config/rofi/config.rasi
@theme "/home/$username/.local/share/rofi/themes/launchpad.rasi"
EOF
chown $username:$username /home/$username/.config/rofi/config.rasi

# Crea un enlace simbolico en /usr/share/images/default a leopard-linux-default.jpg
rm /usr/share/images/desktop-base/default
ln -s /usr/share/images/desktop-base/leopard-linux-default.jpg /usr/share/images/desktop-base/default

# Copio la imagen de fondo de login
cp /root/leopard-post-install/login-background/background.svg /usr/share/desktop-base/active-theme/login/

# Copia la configuracion de la distribución
# rm /etc/os-release
cp os-release /etc/os-release

# Copio el tema de lightdm
# if [ ! -d "/usr/share/lightdm-webkit/themes/" ]; then
  # Crear el directorio.
#   mkdir -p /usr/share/lightdm-webkit/themes/
# fi

# Copio las imagenes de fondo del tema de Grub
cp /root/leopard-post-install/grub-images/grub-4x3.png /usr/share/desktop-base/active-theme/grub/grub-4x3.png
cp /root/leopard-post-install/grub-images/grub-16x9.png /usr/share/desktop-base/active-theme/grub/grub-16x9.png
