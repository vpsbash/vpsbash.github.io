#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

#=====================================================
#	System Required: CentOS 6+/Debian 6+/Ubuntu 14.04+ 
#	Description: Install socks5
#	Version: 0.0.3
#	Author: VPSBASH
#	Email: VPSBASH@GMAIL.COM
#	#Scripts copy from the big guys
#=====================================================

sh_ver="0.0.3"
Info="${Green_font_prefix}[信息]${Font_color_suffix}"
Error="${Red_font_prefix}[错误]${Font_color_suffix}"
Tip="${Green_font_prefix}[注意]${Font_color_suffix}"

check_root(){
	[[ $EUID != 0 ]] && echo -e "${Error} 当前账号非ROOT(或没有ROOT权限)，无法继续操作，请使用${Green_background_prefix} sudo su ${Font_color_suffix}来获取临时ROOT权限（执行后会提示输入当前账号的密码）。" && exit 0
}

check_sys(){
	if [[ -f /etc/redhat-release ]]; then
		release="centos"
	elif cat /etc/issue | grep -q -E -i "debian"; then
		release="debian"
	elif cat /etc/issue | grep -q -E -i "ubuntu"; then
		release="ubuntu"
	elif cat /etc/issue | grep -q -E -i "centos|red hat|redhat"; then
		release="centos"
	elif cat /proc/version | grep -q -E -i "debian"; then
		release="debian"
	elif cat /proc/version | grep -q -E -i "ubuntu"; then
		release="ubuntu"
	elif cat /proc/version | grep -q -E -i "centos|red hat|redhat"; then
		release="centos"
    fi
	bit=`uname -m`
}
S5(){
echo -e "输入你的选择 ${Red_font_prefix}$[v${sh_ver}]{Font_color_suffix}
 ${Green_font_prefix}1.${Font_color_suffix} 安装socks5
 ${Green_font_prefix}2.${Font_color_suffix} 启动socks5
 ${Green_font_prefix}3.${Font_color_suffix} 停止sock5
 ${Green_font_prefix}4.${Font_color_suffix} 卸载socks5
 ${Green_font_prefix}5.${Font_color_suffix} 退出脚本
"
stty erase '^H' && read -p "(默认: 取消):" other_num
	[[ -z "${other_num}" ]] && echo "已取消..." && exit 0
	if [[ ${other_num} == "1" ]]; then
		Socks5_Set
	elif [[ ${other_num} == "2" ]]; then
		Socks5_Up
	elif [[ ${other_num} == "3" ]]; then
		Socks5_Stop
	elif [[ ${other_num} == "4" ]]; then
		Socks5_Unset
	elif [[ ${other_num} == "5" ]]; then
		exit 0
	else
		echo -e "${Error} 请输入正确的数字 [1-4]" && exit 0
	fi
}
Socks5_Set()
{
	check_root
    check_sys
if [[ ${release} == "centos" ]]; then yum -y install wget -y
elif [[ ${release} == "debian" ]]; then apt-get -y install wget -y
elif [[ ${release} == "ubuntu" ]]; then sudo apt-get -y install wget -y
else
		echo -e "${Error} 您的操作系统未在支持列表内" && exit 0
	fi
[ -n "`uname -m | grep "x86_64"`" ] && echo "amd64" && arch="amd64"
[ -n "`uname -m | grep "i686"`" ] && echo "i686" && arch="386"
https://github.com/ginuerzh/gost/releases/download/v2.5/gost_2.5_linux_$arch.tar.gz
tar -zxf gost_2.5_linux_$arch.tar.gz
cp gost_2.5_linux_$arch/gost /usr/bin/gost
rm -rf gost_2.5_linux_$arch*
echo "安装完成，请启动它"
    S5
}
Socks5_Up()
{
    user    
	passwd
	port
nohup gost -L $user:$passwd@:$port socks5://:$port > /dev/null 2>&1 &
echo "nohup gost -L $user:$passwd@:$port socks5://:$port > /dev/null 2>&1 &" >> /etc/rc.local
chmod 755 /etc/rc.local
echo "TeleGrem 专用链接"
IP=$(wget -qO- -t1 -T2 ipinfo.io/ip)
echo " tg://socks?server=$IP&port=$port&user=$user&pass=$passwd "
    S5
}
user(){
echo "请输入要设置的用户名"
	stty erase '^H' && read -p "(默认: user):" user
	[[ -z "${user}" ]] && user="user"
	echo && echo ${Separator_1} && echo -e "	用户名 : ${Green_font_prefix}${user}${Font_color_suffix}" && echo ${Separator_1} && echo
}
passwd(){
echo "请输入要设置的密码"
	stty erase '^H' && read -p "(默认: passwd):" passwd
	[[ -z "${passwd}" ]] && passwd="passwd"
	echo && echo ${Separator_1} && echo -e "	密码 : ${Green_font_prefix}${password}${Font_color_suffix}" && echo ${Separator_1} && echo
}
port(){
echo -e "请输入要开启的端口"
	stty erase '^H' && read -p "(默认: 1234):" port
	[[ -z "${port}" ]] && port="1234"
	echo && echo ${Separator_1} && echo -e "	端口 : ${Green_font_prefix}${port}${Font_color_suffix}" && echo ${Separator_1} && echo
}
Socks5_Stop()
{
    kill -9 $(ps aux | grep "gost" | sed '/grep/d' | awk '{print $2}')
    sed -i '/^nohup.*/d' /etc/rc.local
    S5
}
Socks5_Unset(){
    kill -9 $(ps aux | grep "gost" | sed '/grep/d' | awk '{print $2}')
    sed -i '/^nohup.*/d' /etc/rc.local
    rm -rf /usr/bin/gost
    S5
}
S5
esac
fi
