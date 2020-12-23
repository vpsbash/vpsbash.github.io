#/bin/sh
#=================================================
#	System Required: CentOS 6+/Debian 6+/Ubuntu 14.04+
#	Description: Install SSH Key
#	Version: 0.0.2
#	Author: VPSBASH
#=================================================
cd ~
mkdir .ssh
cd .ssh
rm -f authorized_keys
echo "请输入要设置添加的秘钥"
	stty erase '^H' && read -p "(默认: key):" key
	[[ -z "${key}" ]] && key="key"
	echo && echo ${Separator_1} && echo -e "	秘钥 : ${Green_font_prefix}${key}${Font_color_suffix}" && echo ${Separator_1} && echo
echo "$key" > authorized_keys
chmod 700 authorized_keys
cd ../
chmod 600 .ssh
cd /etc/ssh/

sed -i "/PasswordAuthentication no/c PasswordAuthentication no" sshd_config
sed -i "/RSAAuthentication no/c RSAAuthentication yes" sshd_config
sed -i "/PubkeyAuthentication no/c PubkeyAuthentication yes" sshd_config
sed -i "/PasswordAuthentication yes/c PasswordAuthentication no" sshd_config
sed -i "/RSAAuthentication yes/c RSAAuthentication yes" sshd_config
sed -i "/PubkeyAuthentication yes/c PubkeyAuthentication yes" sshd_config
service sshd restart
service ssh restart
systemctl restart sshd
systemctl restart ssh
cd ~
rm -f key.sh