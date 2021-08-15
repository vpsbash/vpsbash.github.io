	if [ $release = "Debian" ]
	then
		apt install sudo -y && apt install curl sudo lsb-release iptables -y
                echo "deb http://deb.debian.org/debian $(lsb_release -sc)-backports main" | sudo tee /etc/apt/sources.list.d/backports.list
                apt update
                apt -y --no-install-recommends install openresolv dnsutils wireguard-tools
	elif [ $release = "Ubuntu" ]
	then
		apt-get update -y &&  apt install sudo -y
		apt -y --no-install-recommends install openresolv dnsutils wireguard-tools
	fi
wget -N -6 https://cdn.jsdelivr.net/gh/vpsbash/vpsbash.github.io/wgcf -O /usr/local/bin/wgcf
wget -N -6 https://cdn.jsdelivr.net/gh/vpsbash/vpsbash.github.io/wireguard-go -O /usr/bin/wireguard-go
chmod +x /usr/local/bin/wgcf
chmod +x /usr/bin/wireguard-go
echo | wgcf register
until [ $? -eq 0 ]
do
sleep 1s
echo | wgcf register
done
wgcf generate
sed -i 's/engage.cloudflareclient.com/2606:4700:d0::a29f:c001/g' wgcf-profile.conf
sed -i '/\:\:\/0/d' wgcf-profile.conf
cp wgcf-account.toml /etc/wireguard/wgcf-account.toml
cp wgcf-profile.conf /etc/wireguard/wgcf.conf
systemctl enable wg-quick@wgcf
systemctl start wg-quick@wgcf
rm -f wgcf* wireguard-go*
grep -qE '^[ ]*precedence[ ]*::ffff:0:0/96[ ]*100' /etc/gai.conf || echo 'precedence ::ffff:0:0/96  100' | sudo tee -a /etc/gai.conf
yellow " 检测是否成功启动Warp！\n 显示IPV4地址：$(wget -qO- -4 ip.gs) "
green " 如上方显示IPV4地址：8.…………，则说明成功啦！\n 如上方无IP显示，则说明失败喽！！"
