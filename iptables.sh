#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
#=================================================
#	System Required: CentOS 6+/Debian 6+/Ubuntu 14.04+
#	Description: Set up iptables
#	Version: 0.0.1
#	Author: VPSBASH
#	Email: VPSBASH@GMAIL.COM
#	#Scripts copy from the big guys
#================================================

sh_ver="0.0.1"
check_root(){
	[[ $EUID != 0 ]] && echo -e "${Error} 当前账号非ROOT(或没有ROOT权限)，无法继续操作，请使用${Green_background_prefix} sudo su ${Font_color_suffix}来获取临时ROOT权限（执行后会提示输入当前账号的密码）。" && exit 1
}

eck_sys(){
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


Add_iptables(){
echo -e "请输入要开启的端口"
	stty erase '^H' && read -p "(默认: 2333):" port
	[[ -z "$port" ]] && port="2333"
	expr ${port} + 0 &>/dev/null
	if [[ $? == 0 ]]; then
		if [[ ${port} -ge 1 ]] && [[ ${port} -le 65535 ]]; then
			echo && echo ${Separator_1} && echo -e "	端口 : ${Green_font_prefix}${port}${Font_color_suffix}" && echo ${Separator_1} && echo

		else
			echo -e "${Error} 请输入正确的数字(1-65535)"
		fi
	else
		echo -e "${Error} 请输入正确的数字(1-65535)"
	fi
	if [[ ! -z "${port}" ]]; then
		iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport ${port} -j ACCEPT
		iptables -I INPUT -m state --state NEW -m udp -p udp --dport ${port} -j ACCEPT
		ip6tables -I INPUT -m state --state NEW -m tcp -p tcp --dport ${port} -j ACCEPT
		ip6tables -I INPUT -m state --state NEW -m udp -p udp --dport ${port} -j ACCEPT
	fi
	Save_iptables
exit 1
}

Del_iptables(){
echo -e "请输入要关闭的端口"
	stty erase '^H' && read -p "(默认: 2333):" port1
	[[ -z "$port1" ]] && port1="2333"
	expr ${port1} + 0 &>/dev/null
	if [[ $? == 0 ]]; then
		if [[ ${port1} -ge 1 ]] && [[ ${port1} -le 65535 ]]; then
			echo && echo ${Separator_1} && echo -e "	端口 : ${Green_font_prefix}${port1}${Font_color_suffix}" && echo ${Separator_1} && echo

		else
			echo -e "${Error} 请输入正确的数字(1-65535)"
		fi
	else
		echo -e "${Error} 请输入正确的数字(1-65535)"
	fi
	if [[ ! -z "${port1}" ]]; then
		iptables -D INPUT -m state --state NEW -m tcp -p tcp --dport ${port1} -j ACCEPT
		iptables -D INPUT -m state --state NEW -m udp -p udp --dport ${port1} -j ACCEPT
		ip6tables -D INPUT -m state --state NEW -m tcp -p tcp --dport ${port1} -j ACCEPT
		ip6tables -D INPUT -m state --state NEW -m udp -p udp --dport ${port1} -j ACCEPT
	fi
	Save_iptables
	exit 1
}
Save_iptables(){
	if [[ ${release} == "centos" ]]; then
		service iptables save
		service ip6tables save
	else
		iptables-save > /etc/iptables.up.rules
		ip6tables-save > /etc/ip6tables.up.rules
	fi
}


echo -e "  一键配置iptables ${Red_font_prefix}[v${sh_ver}]${Font_color_suffix}
  ${Green_font_prefix}1.${Font_color_suffix} 添加iptables
  ${Green_font_prefix}2.${Font_color_suffix} 删除iptables
 "
	echo && stty erase '^H' && read -p "请输入数字 [1-2]：" num
case "$num" in
	1)
	Add_iptables
	;;
	2)
	Del_iptables
	;;
	*)
	echo -e "${Error} 请输入正确的数字 [1-2]"
	;;
esac
fi
