#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

#=================================================
#	System Required: CentOS 6+/Debian 6+/Ubuntu 14.04+
#	Description: Install Losserver
#	Version: 0.0.2
#	Author: WolfSkylake
#	#Scripts copy from the big guys
#=================================================
sh_ver="0.0.2"
Info="${Green_font_prefix}[信息]${Font_color_suffix}"
Error="${Red_font_prefix}[错误]${Font_color_suffix}"
Tip="${Green_font_prefix}[注意]${Font_color_suffix}"
LotServer_file="/appex/bin/serverSpeeder.sh"
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
LotServer(){
	echo && echo -e "你要做什么？
 ${Green_font_prefix}1.${Font_color_suffix} 一键 更换内核
 ${Green_font_prefix}2.${Font_color_suffix} 安装 LotServer
 ${Green_font_prefix}3.${Font_color_suffix} 卸载 LotServer
————————
 ${Green_font_prefix}4.${Font_color_suffix} 启动 LotServer
 ${Green_font_prefix}5.${Font_color_suffix} 停止 LotServer
 ${Green_font_prefix}6.${Font_color_suffix} 重启 LotServer
 ${Green_font_prefix}7.${Font_color_suffix} 查看 LotServer 状态
 
 注意： 目前脚本不支持Ubuntu18.04和Debian9" && echo
	stty erase '^H' && read -p "(默认: 取消):" lotserver_num
	[[ -z "${lotserver_num}" ]] && echo "已取消..." && exit 1
	if [[ ${lotserver_num} == "1" ]]; then
		Replace_kernel
	elif [[ ${lotserver_num} == "2" ]]; then
		Install_LotServer
	elif [[ ${lotserver_num} == "3" ]]; then
		LotServer_installation_status
		Uninstall_LotServer
	elif [[ ${lotserver_num} == "4" ]]; then
		LotServer_installation_status
		${LotServer_file} start
		${LotServer_file} status
	elif [[ ${lotserver_num} == "5" ]]; then
		LotServer_installation_status
		${LotServer_file} stop
	elif [[ ${lotserver_num} == "6" ]]; then
		LotServer_installation_status
		${LotServer_file} restart
		${LotServer_file} status
	elif [[ ${lotserver_num} == "7" ]]; then
		LotServer_installation_status
		${LotServer_file} status
	else
		echo -e "${Error} 请输入正确的数字(1-6)" && exit 1
	fi
	exit 0
}

Replace_kernel(){
	check_root
    check_sys
if [[ ${release} == "ubuntu" ]]; then
	[ -n "`cat /etc/issue | grep "Ubuntu 18.04"`" ] && echo "Ubuntu 18.04不支持安装锐速" && exit 0
	[ -n "`cat /etc/issue | grep "Ubuntu 16.04"`" ] && echo "Ubuntu 16.04" && KER_VER="4.4.0-47-generic"
	[ -n "`cat /etc/issue | grep "Ubuntu 14.04"`" ] && echo "Ubuntu 14.04" && KER_VER="3.16.0-43-generic"
	sudo apt-get update
	apt-get install -y linux-image-extra-$KER_VER linux-image-$KER_VER
	if [ -n "`dpkg -l | grep "linux-image-extra-$KER_VER"`" ]; then
		del_kernel
		sudo update-grub
		reboot
		exit 0
	else
		ehco -e "${Error} 内核安装失败，请检查你的网络和软件源"
	fi

elif [[ ${release} == "debian" ]]; then
	[ -n "`cat /etc/issue | grep "Linux 9"`" ] && echo "Debian 9不支持安装锐速" && exit 0
	[ -n "`cat /etc/issue | grep "Linux 8"`" ] && echo "Linux 8" && Debian8_kernel
	[ -n "`cat /etc/issue | grep "Linux 7"`" ] && Debian7_kernel

elif [[ ${release} == "centos" ]]; then
	[ -n "`cat /etc/redhat-release |grep "CentOS Linux release 7"`" ] &&
	yum -y install linux-firmware &&
	rpm -ivh http://soft.91yun.org/ISO/Linux/CentOS/kernel/kernel-3.10.0-229.1.2.el7.x86_64.rpm --force
	[ -n "`cat /etc/redhat-release |grep "CentOS release 6"`" ] &&
	rpm -ivh http://soft.91yun.org/ISO/Linux/CentOS/kernel/kernel-firmware-2.6.32-504.3.3.el6.noarch.rpm &&
	rpm -ivh http://soft.91yun.org/ISO/Linux/CentOS/kernel/kernel-2.6.32-504.3.3.el6.x86_64.rpm --force
	reboot

else 
	echo -e "${Error} 您的操作系统未在支持列表内" && exit 0
	fi
exit 0
}
Debian8_kernel(){
[ -n "`cat /etc/issue | grep "Linux 8"`" ] && echo "Linux 8" && KER_VER="3.16.0-4-amd64-dbg" && D_VER="jessie"
	cp /etc/apt/sources.list /etc/apt/sources.list_bak
	echo -e "\ndeb http://ftp.debian.org/debian/ $D_VER-backports main" >> /etc/apt/sources.list
	apt-get update
	apt-get -t $D_VER-backports install linux-image-$KER_VER -y
	if [ -n "`dpkg -l | grep "linux-image-$KER_VER"`" ]; then
	del_kernel
	update-grub
	reboot
	exit 0
else
	ehco -e "${Error} 内核安装失败，请检查你的网络和软件源"
	fi
}
Debian7_kernel(){
	[ -n "`cat /etc/issue | grep "Linux 7"`" ] && echo "Linux 7" && KER_VER="3.2.0-4" && D_VER="wheezy"
	[ -n "`uname -m | grep "x86_64"`" ] && echo "amd64" && arch="amd64"
	[ -n "`uname -m | grep "i686"`" ] && echo "i686" && arch="686-pae"
	cp /etc/apt/sources.list /etc/apt/sources.list_bak
	echo -e "\ndeb http://ftp.debian.org/debian/ $D_VER-backports main" >> /etc/apt/sources.list
	apt-get update
	apt-get -t $D_VER-backports install linux-image-$KER_VER-$arch -y
	if [ -n "`dpkg -l | grep "linux-image-$KER_VER-$arch"`" ]; then
	del_kernel
	update-grub
	reboot
	exit 0
else
	ehco -e "${Error} 内核安装失败，请检查你的网络和软件源"
	fi
}
del_kernel(){
	deb_total=`dpkg -l | grep linux-image | awk '{print $2}' | grep -v "${KER_VER}" | wc -l`
	if [[ "${deb_total}" -ge "1" ]]; then
		echo -e "${Info} 检测到 ${deb_total} 个其余内核，开始卸载..."
		for((integer = 1; integer <= ${deb_total}; integer++))
		do
			deb_del=`dpkg -l|grep linux-image | awk '{print $2}' | grep -v "${KER_VER}" | head -${integer}`
			echo -e "${Info} 开始卸载 ${deb_del} 内核..."
			apt-get purge -y ${deb_del}
			echo -e "${Info} 卸载 ${deb_del} 内核卸载完成，继续..."
		done
		deb_total=`dpkg -l|grep linux-image | awk '{print $2}' | wc -l`
		if [[ "${deb_total}" = "1" ]]; then
			echo -e "${Info} 内核卸载完毕，继续..."
		else
			echo -e "${Error} 内核卸载异常，请检查 !" && exit 1
		fi
	else
		echo -e "${Info} 检测到 除刚安装的内核以外已无多余内核，跳过卸载多余内核步骤 !"
	fi
}
Install_LotServer(){
    check_sys
if [[ ${release} == "centos" ]]; then
    yum install wget -y
elif [[ ${release} == "debian" ]]; then
    apt-get install -y
elif [[ ${release} == "ubuntu" ]]; then
    sudo apt-get install wget -y
else
		echo -e "${Error} 您的操作系统未在支持列表内" && exit 1
fi	
	[[ -e ${LotServer_file} ]] && echo -e "${Error} LotServer 已安装 !" && exit 1
	#Github: https://github.com/0oVicero0/serverSpeeder_Install
	wget --no-check-certificate -qO /tmp/appex.sh "https://raw.githubusercontent.com/0oVicero0/serverSpeeder_Install/master/appex.sh"
	[[ ! -e "/tmp/appex.sh" ]] && echo -e "${Error} LotServer 安装脚本下载失败 !" && exit 1
	bash /tmp/appex.sh 'install'
	sleep 2s
	PID=`ps -ef |grep -v grep |grep "appex" |awk '{print $2}'`
	if [[ ! -z ${PID} ]]; then
		echo -e "${Info} LotServer 安装完成 !" && exit 1
	else
		echo -e "${Error} LotServer 安装失败 !" && exit 1
	fi
}
Uninstall_LotServer(){
	echo "确定要卸载 LotServer？[y/N]" && echo
	stty erase '^H' && read -p "(默认: n):" unyn
	[[ -z ${unyn} ]] && echo && echo "已取消..." && exit 1
	if [[ ${unyn} == [Yy] ]]; then
		wget --no-check-certificate -qO /tmp/appex.sh "https://raw.githubusercontent.com/0oVicero0/serverSpeeder_Install/master/appex.sh" && bash /tmp/appex.sh 'uninstall'
		echo && echo "LotServer 卸载完成 !" && echo
	fi
}


LotServer
esac
fi
