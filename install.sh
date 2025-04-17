#!/bin/bash

# SET DOMAIN
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e " Masukkan Domain Yang Sudah Du pointing Ke IP VPS"
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
read -p "Enter :" domen
mkdir -p /etc/xray/
echo $domen > /root/domain
echo "$domen" > /etc/xray/domain

# UBAH TIME ZONE
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

# DISABLE IPV6
sysctl -w net.ipv6.conf.all.disable_ipv6=1 >/dev/null 2>&1
sysctl -w net.ipv6.conf.default.disable_ipv6=1 >/dev/null 2>&1

# INSTALL XRAY
wget https://raw.githubusercontent.com/Sandhj/Premium-SC/main/installer/install-xray.sh && chmod +x install-xray.sh && ./install-xray.sh

# INSTALL MENU
wget https://raw.githubusercontent.com/Paper890/mysc/main/installer/install-menu.sh && chmod +x install-menu.sh && ./install-menu.sh

# PASANG DEFAULT MENU
cat> /root/.profile << END
# ~/.profile: executed by Bourne-compatible login shells.

if [ "$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi

mesg n || true
clear
menu
END
chmod 644 /root/.profile

echo " DONE SETUP"

# HAPUS FILE INSTALLER
cd
rm *
