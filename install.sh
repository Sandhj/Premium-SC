#!/bin/bash

echo -e "╭══════════════════════════════════════════╮"
echo -e "│             Please Insert Your Domain"
echo -e "╰══════════════════════════════════════════╯"
read -p "   Your Domain : " dnss
mkdir -p /etc/xray
touch /etc/xray/domain
echo "$dnss" > /root/domain
echo "$dnss" > /etc/xray/domain
echo "IP=$dnss" > /var/lib/ipvps.conf


echo -e "╭══════════════════════════════════════════╮"
echo -e "│             INSTALL SSH/OVPN
echo -e "╰══════════════════════════════════════════╯"
wget https://raw.githubusercontent.com/king-vpn/autoscript-vip/main/install/ssh-vpn.sh && chmod +x ssh-vpn.sh && ./ssh-vpn.sh
clear


echo -e "╭══════════════════════════════════════════╮"
echo -e "│             INSTALL XRAY
echo -e "╰══════════════════════════════════════════╯"
wget https://raw.githubusercontent.com/king-vpn/autoscript-vip/main/install/ins-xray.sh && chmod +x ins-xray.sh && ./ins-xray.sh
clear


echo -e "╭══════════════════════════════════════════╮"
echo -e "│             INSTALL WEBSOCKET
echo -e "╰══════════════════════════════════════════╯"
wget https://raw.githubusercontent.com/king-vpn/autoscript-vip/main/sshws/insshws.sh && chmod +x insshws.sh && ./insshws.sh
clear


echo -e "╭══════════════════════════════════════════╮"
echo -e "│             INSTALL OHP
echo -e "╰══════════════════════════════════════════╯"
wget https://raw.githubusercontent.com/king-vpn/autoscript-vip/main/sshws/ohp.sh && chmod +x ohp.sh && ./ohp.sh
clear


echo -e "╭══════════════════════════════════════════╮"
echo -e "│             INSTALL MENU
echo -e "╰══════════════════════════════════════════╯"
wget https://raw.githubusercontent.com/king-vpn/autoscript-vip/main/update.sh && chmod +x update.sh && ./update.sh
clear


cat> /root/.profile << END
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


cd
rm -rf *

echo -e "╭══════════════════════════════════════════╮"
echo -e "│             ISNTALL SUCCESSFULLY 
echo -e "╰══════════════════════════════════════════╯"
echo -e " Do you want to reboot now ? (y/n)? "; read answer
if [ "$answer" == "${answer#[Yy]}" ] ;then
exit 0
else
reboot
fi
