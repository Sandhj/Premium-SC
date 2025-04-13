#!/bin/bash

# UBAH TIME ZONE KE GMT +7
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

# DISABLE IPV6
sysctl -w net.ipv6.conf.all.disable_ipv6=1 >/dev/null 2>&1
sysctl -w net.ipv6.conf.default.disable_ipv6=1 >/dev/null 2>&1

# KONFIGURASI DOMAIN
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e " INPUT YOUR DOMAIN BELOW. POINTING BEFORE YOU DROP"
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
read -rp "Your Domain Installation : " domen
 
    mkdir -p /etc/xray/ 
    echo $domen > /root/domain
    echo "$domen" > /root/domain
    echo "$domen" > /etc/xray/domain
    
# INSTALL PAKET
apt update -y
apt install python3 -y
apt update -y
apt install git curl -y
apt dist-upgrade -y
apt install sudo -y
apt-get remove --purge ufw firewalld -y 
apt-get remove --purge exim4 -y 

apt install -y screen curl jq bzip2 gzip coreutils rsyslog iftop \
htop zip unzip net-tools sed gnupg gnupg1 \
bc sudo apt-transport-https build-essential dirmngr libxml-parser-perl neofetch screenfetch git lsof \
openssl openvpn easy-rsa fail2ban tmux \
stunnel4 vnstat squid \
dropbear  libsqlite3-dev \
socat cron bash-completion ntpdate xz-utils sudo apt-transport-https \
gnupg2 dnsutils lsb-release chrony

/etc/init.d/vnstat restart
wget -q https://humdi.net/vnstat/vnstat-2.6.tar.gz
tar zxvf vnstat-2.6.tar.gz
cd vnstat-2.6
./configure --prefix=/usr --sysconfdir=/etc >/dev/null 2>&1 && make >/dev/null 2>&1 && make install >/dev/null 2>&1
cd
vnstat -u -i $NET
sed -i 's/Interface "'""eth0""'"/Interface "'""$NET""'"/g' /etc/vnstat.conf
chown vnstat:vnstat /var/lib/vnstat -R
systemctl enable vnstat
/etc/init.d/vnstat restart
rm -f /root/vnstat-2.6.tar.gz >/dev/null 2>&1
rm -rf /root/vnstat-2.6 >/dev/null 2>&1

apt install -y libnss3-dev libnspr4-dev pkg-config libpam0g-dev libcap-ng-dev libcap-ng-utils libselinux1-dev libcurl4-nss-dev flex bison make libnss3-tools libevent-dev xl2tpd pptpd

# END INSTALL PAKET

# INSTALL MODUL VPN
wget https://raw.githubusercontent.com/Paper890/sandi/main/ssh/ssh-vpn.sh && chmod +x ssh-vpn.sh && ./ssh-vpn.sh
wget https://raw.githubusercontent.com/Paper890/sandi/main/xray/ins-xray.sh && chmod +x ins-xray.sh && ./ins-xray.sh
wget https://raw.githubusercontent.com/Paper890/sandi/main/websocket/insshws.sh && chmod +x insshws.sh && ./insshws.sh
wget https://raw.githubusercontent.com/Paper890/sandi/main/websocket/nontls.sh && chmod +x nontls.sh && ./nontls.sh

# DOWNLOAD MENU-MENU
wget https://raw.githubusercontent.com/Paper890/sandi/main/update/update.sh && chmod +x update.sh && ./update.sh
rm -f update.sh

# SETTING DEFAULT MENU
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

echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e " INSTALLASI BERHASIL. SILAHKAN REBOOT VPS ANDA "
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
