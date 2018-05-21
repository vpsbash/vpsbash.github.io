#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

#=================================================
#	System Required: CentOS 6+/Debian 6+/Ubuntu 14.04+
#	Description: Test the vps and install the software
#	Version: 0.0.6
#	Author: VPSBASH
#	Email: VPSBASH@GMAIL.COM
#	#Scripts copy from the big guys
#=================================================
sh_ver="0.0.6"
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

#一级菜单
start(){
echo -e " VPS一键管理脚本 ${Red_font_prefix}[v${sh_ver}]${Font_color_suffix}
    ${Green_font_prefix}1.${Font_color_suffix} VPS测试
    ${Green_font_prefix}2.${Font_color_suffix} 软件安装
    ${Green_font_prefix}3.${Font_color_suffix} 退出脚本
 " 
	stty erase '^H' && read -p "请输入数字 [1-3]：" num
	if [[ ${num} == "1" ]]; then
		VPS_TEST
	elif [[ ${num} == "2" ]]; then
		Install_Software
	elif [[ ${num} == "3" ]]; then
		exit 0
	else
	echo -e "${Error} 请输入正确的数字 [1-3]" && exit 0
	fi
}

#二级菜单
VPS_TEST(){
echo && echo -e "你要测试什么脚本? ${Red_font_prefix}${Font_color_suffix}
 ${Green_font_prefix}1.${Font_color_suffix} ZBench
 ${Green_font_prefix}2.${Font_color_suffix} TestYourVPS
 ${Green_font_prefix}3.${Font_color_suffix} Superbench
 ${Green_font_prefix}4.${Font_color_suffix} Bench
 ${Green_font_prefix}5.${Font_color_suffix} Unixbench
" && echo
stty erase '^H' && read -p "(默认: 取消):" other_num
	[[ -z "${other_num}" ]] && echo "已取消..." && start
	if [[ ${other_num} == "1" ]]; then
		ZBench
	elif [[ ${other_num} == "2" ]]; then
		TestYourVPS
	elif [[ ${other_num} == "3" ]]; then
		Superbench
	elif [[ ${other_num} == "4" ]]; then
		Bench
	elif [[ ${other_num} == "5" ]]; then
		Unixbench

	else
		echo -e "${Error} 请输入正确的数字 [1-5]" && start
	fi
}

#三级菜单
ZBench() {
echo && echo -e "版本选择
 ${Green_font_prefix}1.${Font_color_suffix} ZBench_EN去除上传版本
 ${Green_font_prefix}2.${Font_color_suffix} ZBench_CN去除上传版本
 ${Green_font_prefix}3.${Font_color_suffix} ZBench_EN默认版本
 ${Green_font_prefix}4.${Font_color_suffix} ZBench_CN默认版本
" && echo
stty erase '^H' && read -p "(默认: 取消):" other_num
	[[ -z "${other_num}" ]] && echo "已取消..." && VPS_TEST
	if [[ ${other_num} == "1" ]]; then
		ZBench_1
	elif [[ ${other_num} == "2" ]]; then
		ZBench_2
	elif [[ ${other_num} == "3" ]]; then
		ZBench_3
	elif [[ ${other_num} == "4" ]]; then
		ZBench_4
	else
		echo -e "${Error} 请输入正确的数字 [1-4]" && VPS_TEST
    fi
}
ZBench_1() {
	rm -f ZBench.sh 
    wget -N --no-check-certificate https://vpsbash.github.io/ZBench.sh && bash ZBench.sh
    rm -f ZBench.sh
	exit 0
}
ZBench_2() {
    rm -f ZBench-CN.sh
	wget -N --no-check-certificate https://vpsbash.github.io/ZBench-CN.sh && bash ZBench-CN.sh
    rm -f ZBench-CN.sh
	exit 0
}
ZBench_3() {
	rm -f ZBench.sh
	wget -N --no-check-certificate https://raw.githubusercontent.com/FunctionClub/ZBench/master/ZBench.sh && bash ZBench.sh
	rm -f ZBench.sh
	exit 0
}
ZBench_4() {
    rm -f ZBench-CN.sh
	wget -N --no-check-certificate https://raw.githubusercontent.com/FunctionClub/ZBench/master/ZBench-CN.sh && bash ZBench-CN.sh
    rm -f ZBench-CN.sh
	exit 0
}

#三级菜单
TestYourVPS(){
echo && echo -e "版本选择
 ${Green_font_prefix}1.${Font_color_suffix} TestYourVPS英文版
 ${Green_font_prefix}2.${Font_color_suffix} TestYourVPS中文版
" && echo
stty erase '^H' && read -p "(默认: 取消):" other_num
	[[ -z "${other_num}" ]] && echo "已取消..." && VPS_TEST
	if [[ ${other_num} == "1" ]]; then
		TestYourVPS_1
	elif [[ ${other_num} == "2" ]]; then
		TestYourVPS_2
	else
		echo -e "${Error} 请输入正确的数字 [1-2]" && VPS_TEST
    fi
}
TestYourVPS_1(){
    rm -f test-en.sh
    wget -qO- --no-check-certificate https://raw.githubusercontent.com/SunsetLast/TestYourVPS/master/test-en.sh | bash test-en.sh 
    rm -f test-en.sh 
	exit 0
}
TestYourVPS_2(){
    rm -f test.sh
    wget -qO- --no-check-certificate https://raw.githubusercontent.com/SunsetLast/TestYourVPS/master/test.sh | bash test.sh
    rm -f test.sh
	exit 0
}

#三级菜单
Superbench(){
echo && echo -e "版本选择
 ${Green_font_prefix}1.${Font_color_suffix} Superbench新版
 ${Green_font_prefix}2.${Font_color_suffix} Superbench旧版
 ${Green_font_prefix}3.${Font_color_suffix} Superspeed古董版
" && echo
stty erase '^H' && read -p "(默认: 取消):" other_num
	[[ -z "${other_num}" ]] && echo "已取消..." && VPS_TEST
	if [[ ${other_num} == "1" ]]; then
		Superbench_1
	elif [[ ${other_num} == "2" ]]; then
		Superbench_2
	elif [[ ${other_num} == "3" ]]; then
		Superspeed_1
	else
		echo -e "${Error} 请输入正确的数字 [1-3]" && VPS_TEST
    fi
}
Superbench_1(){
    rm -f superbench.sh
wget -qO- git.io/superbench.sh | bash
    rm -f superbench.sh
exit 0
}
Superbench_2(){
    rm -f superbench_old.sh
wget -qO- git.io/superbench_old.sh | bash
    rm -f superbench_old.sh
exit 0
}
Superspeed_1(){
rm -f superspeed.sh
wget https://raw.githubusercontent.com/oooldking/script/master/superspeed.sh && chmod +x superspeed.sh && ./superspeed.sh
rm -f superspeed.sh
exit 0
}

#三级菜单
Bench(){
echo && echo -e "版本选择
 ${Green_font_prefix}1.${Font_color_suffix} Bench传统脚本
 ${Green_font_prefix}2.${Font_color_suffix} 退出脚本
" && echo
stty erase '^H' && read -p "(默认: 取消):" other_num
	[[ -z "${other_num}" ]] && echo "已取消..." && VPS_TEST
	if [[ ${other_num} == "1" ]]; then
		Bench_1
	elif [[ ${other_num} == "2" ]]; then
		exit 0
	else
		echo -e "${Error} 请输入正确的数字 [1-3]" && VPS_TEST
    fi
}
Bench_1(){
rm -f bench.sh
wget -qO- bench.sh | bash
rm -f bench.sh
exit 0
}

Unixbench_1(){
rm -f unixbench.sh
wget --no-check-certificate https://github.com/teddysun/across/raw/master/unixbench.sh
chmod +x unixbench.sh
./unixbench.sh
rm -f unixbench.sh
exit 0
}

#三级菜单
Unixbench(){
echo && echo -e "版本选择
 ${Green_font_prefix}1.${Font_color_suffix} Unixbench传统脚本
 ${Green_font_prefix}2.${Font_color_suffix} 退出脚本
" && echo
stty erase '^H' && read -p "(默认: 取消):" other_num
	[[ -z "${other_num}" ]] && echo "已取消..." && VPS_TEST
	if [[ ${other_num} == "1" ]]; then
		Unixbench_1
	elif [[ ${other_num} == "2" ]]; then
		exit 0
	else
		echo -e "${Error} 请输入正确的数字 [1-3]" && VPS_TEST
    fi
}

#二级菜单
Install_Software(){ echo -e "你要安装什么环境?
 ${Green_font_prefix}1.${Font_color_suffix} 基本环境安装
 ${Green_font_prefix}2.${Font_color_suffix} 安装LAMP/LNMP面板
 ${Green_font_prefix}3.${Font_color_suffix} 安装LNMP/LNMP一键安装包
 ${Green_font_prefix}4.${Font_color_suffix} 安装BBR/锐速
 ${Green_font_prefix}5.${Font_color_suffix} 安装魔法上网软件
" && echo
stty erase '^H' && read -p "(默认: 取消):" other_num
	[[ -z "${other_num}" ]] && echo "已取消..." && start
	if [[ ${other_num} == "1" ]]; then
		Basic_Et
	elif [[ ${other_num} == "2" ]]; then
		Panel
	elif [[ ${other_num} == "3" ]]; then
		LNMP
	elif [[ ${other_num} == "4" ]]; then
		BBRLos
	elif [[ ${other_num} == "5" ]]; then
		FQ

	else
		echo -e "${Error} 请输入正确的数字 [1-5]" && start
	fi
}
Basic_Et(){
    check_sys
	if [[ ${release} == "centos" ]] ; then
    echo "nameserver 8.8.8.8
    nameserver 208.67.222.222" > /etc/resolv.conf
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
    yum update -y
    yum install wget curl git vim unzip cron python screen -y
elif [[ ${release} == "debian" ]]; then
    echo "nameserver 8.8.8.8
    nameserver 208.67.222.222" > /etc/resolv.conf
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
    apt-get update -y
    apt-get install wget curl git vim unzip cron python screen -y
elif [[ ${release} == "ubuntu" ]]; then
    echo "nameserver 8.8.8.8
    nameserver 208.67.222.222" > /etc/resolv.conf
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
    sudo apt-get update -y
    sudo apt-get install wget curl git vim unzip cron python screen -y
else
		echo -e "${Error} 您的操作系统未在支持列表内" && Install_Software
	fi
Install_Software
}

#三级菜单
Panel(){
echo && echo -e "你要安装什么面板? ${Red_font_prefix}${Font_color_suffix}
 ${Green_font_prefix}1.${Font_color_suffix} BT
 ${Green_font_prefix}2.${Font_color_suffix} AppNode
 ${Green_font_prefix}3.${Font_color_suffix} CyberPanel
  ${Tip}Appnode和CyberPanel只支持Centos系列系统
" && echo
stty erase '^H' && read -p "(默认: 取消):" other_num
	[[ -z "${other_num}" ]] && echo "已取消..." && Install_Software
	if [[ ${other_num} == "1" ]]; then
		BT
	elif [[ ${other_num} == "2" ]]; then
		AppNode
	elif [[ ${other_num} == "3" ]]; then
		CyberPanel

	else
		echo -e "${Error} 请输入正确的数字 [1-3]" && Install_Software
	fi
}
BT(){
    check_sys
if [[ ${release} == "centos" ]]; then
    yum install -y wget && wget -O install.sh http://download.bt.cn/install/install.sh && sh install.sh
elif [[ ${release} == "debian" ]]; then
    apt-get update -y
    apt-get install vim wget unzip cron git unrar-free curl python screen libncurses-dev gawk sed grep virt-what cmake libncurses5-dev libssl-dev libcurl4-openssl-dev pkg-config libicu-dev libfreetype6-dev -y
    wget -O install.sh http://download.bt.cn/install/install-ubuntu.sh && bash install.sh
elif [[ ${release} == "ubuntu" ]]; then
    sudo apt-get update -y
    sudo apt-get install vim wget unzip cron git unrar-free curl python screen libncurses-dev gawk sed grep virt-what cmake libncurses5-dev libssl-dev libcurl4-openssl-dev pkg-config libicu-dev libfreetype6-dev -y
    wget -O install.sh http://download.bt.cn/install/install-ubuntu.sh && sudo bash install.sh
else
		echo -e "${Error} 您的操作系统未在支持列表内" && Panel
	fi
}
AppNode(){
    check_sys
if [[ ${release} == "centos" ]]; then
    INSTALL_AGENT=1 INSTALL_APPS=sitemgr INIT_SWAPFILE=1 INSTALL_PKGS='nginx-stable,php56(zend-guard-loader/ioncube-loader/source-guardian-loader),php55(zend-guard-loader/ioncube-loader/source-guardian-loader),php54(zend-guard-loader/ioncube-loader/source-guardian-loader),php53(zend-guard-loader/ioncube-loader/source-guardian-loader),php72(zend-guard-loader/ioncube-loader/source-guardian-loader),php71(zend-guard-loader/ioncube-loader/source-guardian-loader),php70(zend-guard-loader/ioncube-loader/source-guardian-loader),pureftpd,mysql56' bash -c "$(curl -sS http://dl.appnode.com/install.sh)"
else
		echo -e "${Error} 您的操作系统未在支持列表内" && Panel
	fi
}
CyberPanel(){
    check_sys
if [[ ${release} == "centos" ]]; then
    sh <(curl https://cyberpanel.net/install.sh || wget -O - https://cyberpanel.net/install.sh)
else
		echo -e "${Error} 您的操作系统未在支持列表内" && Panel
	fi
}

#三级菜单
LNMP(){ echo -e "你要安装什么一键安装包?
 ${Green_font_prefix}1.${Font_color_suffix} LNNP一键安装脚本
 ${Green_font_prefix}2.${Font_color_suffix} LAMP一键安装脚本
 ${Green_font_prefix}3.${Font_color_suffix} OneinStack
 ${Green_font_prefix}4.${Font_color_suffix} LAMP一键yum安装脚本(适合小内存)
" && echo
stty erase '^H' && read -p "(默认: 取消):" other_num
	[[ -z "${other_num}" ]] && echo "已取消..." && Install_Software
	if [[ ${other_num} == "1" ]]; then
		LNMP_1
	elif [[ ${other_num} == "2" ]]; then
		LAMP
	elif [[ ${other_num} == "3" ]]; then
		OneinStack
	elif [[ ${other_num} == "4" ]]; then
		LAMP_YUM
	else
		echo -e "${Error} 请输入正确的数字 [1-4]" && Install_Software
	fi
}
LNMP_1(){
    check_sys
if [[ ${release} == "centos" ]]; then
    yum install screen wget -y
elif [[ ${release} == "debian" ]]; then
    apt-get install screen wget -y
elif [[ ${release} == "ubuntu" ]]; then
    sudo apt-get install screen wget -y
else
		echo -e "${Error} 您的操作系统未在支持列表内" && LNMP
	fi
wget -c http://soft.vpser.net/lnmp/lnmp1.4.tar.gz && tar zxf lnmp1.4.tar.gz && cd lnmp1.4 && ./install.sh lnmp
exit 0
}
LAMP(){
    check_sys
if [[ ${release} == "centos" ]]; then
yum install wget screen git -y 
elif [[ ${release} == "debian" ]]; then
    apt-get install screen wget git -y
elif [[ ${release} == "ubuntu" ]]; then
    sudo apt-get install screen wget git -y
else
		echo -e "${Error} 您的操作系统未在支持列表内" && LNMP
	fi
git clone https://github.com/teddysun/lamp.git
cd lamp
chmod +x *.sh
screen -S lamp
./lamp.sh
exit 0
}
OneinStack(){
    check_sys
if [[ ${release} == "centos" ]]; then
    yum install wget screen curl python -y
elif [[ ${release} == "debian" ]]; then
    apt-get install wget screen curl python -y
elif [[ ${release} == "ubuntu" ]]; then
    sudo apt-get install wget screen curl python -y
else
		echo -e "${Error} 您的操作系统未在支持列表内" && LNMP
fi
wget http://mirrors.linuxeye.com/oneinstack-full.tar.gz
tar xzf oneinstack-full.tar.gz
cd oneinstack
screen -S oneinstack
./install.sh
exit 0
}
LAMP_YUM(){
    check_sys
if [[ ${release} == "centos" ]]; then
    wget --no-check-certificate https://github.com/teddysun/lamp-yum/archive/master.zip -O lamp-yum.zip
    unzip lamp-yum.zip
    cd lamp-yum-master/
    chmod +x *.sh
    ./lamp.sh 2>&1 | tee lamp.log
    exit 0
else
		echo -e "${Error} 您的操作系统未在支持列表内" && LNMP
fi
}

#三级菜单
BBRLos(){ echo -e "你要安装什么？
  ${Green_font_prefix}1.${Font_color_suffix} KVM - BBR
  ${Green_font_prefix}2.${Font_color_suffix} KVM - 锐速
  ${Green_font_prefix}3.${Font_color_suffix} KVM - LotServer
  ${Green_font_prefix}4.${Font_color_suffix} KVM - 魔改BBR
  ${Green_font_prefix}5.${Font_color_suffix} OVZ - 魔改BBR
  ${Tip} 锐速/LotServer 不支持 OpenVZ！
  ${Tip} 锐速和LotServer不能共存！
"
	stty erase '^H' && read -p "(默认: 取消):" other_num
	[[ -z "${other_num}" ]] && echo "已取消..." && Install_Software
	if [[ ${other_num} == "1" ]]; then
		BBR_1
	elif [[ ${other_num} == "2" ]]; then
		Server_Speeder
	elif [[ ${other_num} == "3" ]]; then
		LotServer
	elif [[ ${other_num} == "4" ]]; then
		BBR_2
	elif [[ ${other_num} == "5" ]]; then
		BBR_3
	else
		echo -e "${Error} 请输入正确的数字 [1-5]" && Install_Software
	fi
}
BBR_1(){
    check_sys
if [[ ${release} == "debian" ]]; then
    rm -f bbr.sh
    wget -N --no-check-certificate https://raw.githubusercontent.com/ToyoDAdoubi/doubi/master/bbr.sh && chmod +x bbr.sh && bash bbr.sh
    rm -f bbr.sh
elif [[ ${release} == "ubuntu" ]]; then
    rm -f bbr.sh
    wget -N --no-check-certificate https://raw.githubusercontent.com/ToyoDAdoubi/doubi/master/bbr.sh && chmod +x bbr.sh && bash bbr.sh
    rm -f bbr.sh
elif [[ ${release} == "centos" ]]; then
    rm -f bbr.sh
    wget -N --no-check-certificate https://github.com/teddysun/across/raw/master/bbr.sh && chmod +x bbr.sh && bash bbr.sh
    rm -f bbr.sh
else
		echo -e "${Error} 您的操作系统未在支持列表内" && BBRLos
	fi
    exit 0
}
Server_Speeder(){
    rm -f serverspeeder.sh
    wget -N --no-check-certificate https://github.com/91yun/serverspeeder/raw/master/serverspeeder.sh && bash serverspeeder.sh
    rm -f serverspeeder.sh
    exit 0
}
LotServer(){
    rm -f appex.sh
    wget --no-check-certificate -qO /tmp/appex.sh "https://raw.githubusercontent.com/0oVicero0/serverSpeeder_Install/master/appex.sh" && bash /tmp/appex.sh 'install'
    rm -f appex.sh
    exit 0
}
BBR_2(){
    check_sys
if [[ ${release} == "centos" ]]; then 
    rm -f tcp_nanqinlang-1.3.2.sh 
    wget https://raw.githubusercontent.com/tcp-nanqinlang/general/master/General/CentOS/bash/tcp_nanqinlang-1.3.2.sh
    bash tcp_nanqinlang-1.3.2.sh
    rm -f tcp_nanqinlang-1.3.2.sh 
elif [[ ${release} == "debian" ]]; then
    rm -f tcp_nanqinlang-1.3.2.sh 
    wget https://github.com/tcp-nanqinlang/general/releases/download/3.4.2.1/tcp_nanqinlang-fool-1.3.0.sh
    bash tcp_nanqinlang-fool-1.3.0.sh
    rm -f tcp_nanqinlang-1.3.2.sh 
elif [[ ${release} == "ubuntu" ]]; then
    rm -f tcp_nanqinlang-1.3.2.sh 
    wget https://github.com/tcp-nanqinlang/general/releases/download/3.4.2.1/tcp_nanqinlang-fool-1.3.0.sh
    bash tcp_nanqinlang-fool-1.3.0.sh
    rm -f tcp_nanqinlang-1.3.2.sh 
else
		echo -e "${Error} 您的操作系统未在支持列表内" && BBRLos
	fi
    exit 0
}
BBR_3(){
    check_sys
if [[ ${release} == "centos" ]]; then 
    rm -f tcp_nanqinlang-rinetd-centos-multiNIC.sh
    wget https://github.com/tcp-nanqinlang/lkl-rinetd/releases/download/1.1.0/tcp_nanqinlang-rinetd-centos-multiNIC.sh
    bash tcp_nanqinlang-rinetd-centos-mult iNIC.sh
    rm -f tcp_nanqinlang-rinetd-centos-multiNIC.sh
elif [[ ${release} == "debian" ]]; then
    rm -f tcp_nanqinlang-rinetd-debianorubuntu-multiNIC.sh
    wget https://github.com/tcp-nanqinlang/lkl-rinetd/releases/download/1.1.0/tcp_nanqinlang-rinetd-debianorubuntu-multiNIC.sh
    bash tcp_nanqinlang-rinetd-debianorubuntu-multiNIC.sh
    rm -f tcp_nanqinlang-rinetd-debianorubuntu-multiNIC.sh
elif [[ ${release} == "ubuntu" ]]; then
    rm -f tcp_nanqinlang-rinetd-debianorubuntu-multiNIC.sh
    wget https://github.com/tcp-nanqinlang/lkl-rinetd/releases/download/1.1.0/tcp_nanqinlang-rinetd-debianorubuntu-multiNIC.sh
    bash tcp_nanqinlang-rinetd-debianorubuntu-multiNIC.sh
    rm -f tcp_nanqinlang-rinetd-debianorubuntu-multiNIC.sh
else
		echo -e "${Error} 您的操作系统未在支持列表内" && BBRLos
	fi
    exit 0
}

#三级菜单
FQ(){ echo -e "你要安装什么软件?
 ${Green_font_prefix}1.${Font_color_suffix} ShadowsocksRR MudbJSON
 ${Green_font_prefix}2.${Font_color_suffix} Shadowsocks(R) 4 in 1
 ${Green_font_prefix}3.${Font_color_suffix} V2ray 一键
 ${Green_font_prefix}4.${Font_color_suffix} V2ray 面板
 ${Green_font_prefix}5.${Font_color_suffix} V2ray 原版
 ${Green_font_prefix}6.${Font_color_suffix} Socks5
" && echo
stty erase '^H' && read -p "(默认: 取消):" other_num
	[[ -z "${other_num}" ]] && echo "已取消..." && Install_Software
	if [[ ${other_num} == "1" ]]; then
		SSRR
	elif [[ ${other_num} == "2" ]]; then
		SS4in1
	elif [[ ${other_num} == "3" ]]; then
		V2_1
	elif [[ ${other_num} == "4" ]]; then
		V2_2
	elif [[ ${other_num} == "5" ]]; then
		V2_3
	elif [[ ${other_num} == "6" ]]; then
		S5

	else
		echo -e "${Error} 请输入正确的数字 [1-6]" && Install_Software
	fi
}
SSRR(){
    rm -f ssrmu.sh
wget -N --no-check-certificate https://raw.githubusercontent.com/FanhuaCloud/Shadowsocksrrmu/master/ssrmu.sh && chmod +x ssrmu.sh && bash ssrmu.sh
    rm -f ssrmu.sh
    exit 0
}

SS4in1(){
    rm -f shadowsocks-all.sh
wget --no-check-certificate https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks-all.sh
chmod +x shadowsocks-all.sh
./shadowsocks-all.sh 2>&1 | tee shadowsocks-all.log
    rm -f shadowsocks-all.sh
    exit 0
}
V2_1(){
    check_sys
if [[ ${release} == "centos" ]]; then yum update -y && yum install curl -y
elif [[ ${release} == "debian" ]]; then apt-get update -y && apt-get install curl -y
elif [[ ${release} == "ubuntu" ]]; then sudo aapt-get update -y && apt-get install curl -y
else
		echo -e "${Error} 您的操作系统未在支持列表内" && exit 0
	fi
    rm -f v2ray.sh
bash <(curl -s -L https://233blog.com/v2ray.sh)
    exit 0
}
V2_2(){
    rm -f install.sh
    wget -N --no-check-certificate https://raw.githubusercontent.com/FunctionClub/V2ray.Fun/master/install.sh && bash install.sh
    rm -f install.sh
    exit 0
}
V2_3(){
    rm -f install.sh
    bash -c "$(curl -fsSL https://git.io/vpOeN)"
    rm -f install.sh
    exit 0
}

#四级菜单
S5(){
echo -e "输入你的选择 ${Red_font_prefix}${Font_color_suffix}
 ${Green_font_prefix}1.${Font_color_suffix} 安装socks5
 ${Green_font_prefix}2.${Font_color_suffix} 启动socks5
 ${Green_font_prefix}3.${Font_color_suffix} 停止sock5
 ${Green_font_prefix}4.${Font_color_suffix} 卸载socks5
 ${Green_font_prefix}5.${Font_color_suffix} 退出脚本
"
stty erase '^H' && read -p "(默认: 取消):" other_num
	[[ -z "${other_num}" ]] && echo "已取消..." && FQ
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
		echo -e "${Error} 请输入正确的数字 [1-4]" && FQ
	fi
}
Socks5_Set()
{
    check_sys
if [[ ${release} == "centos" ]]; then yum -y install wget -y
elif [[ ${release} == "debian" ]]; then apt-get -y install wget -y
elif [[ ${release} == "ubuntu" ]]; then sudo apt-get -y install wget -y
else
		echo -e "${Error} 您的操作系统未在支持列表内" && FQ
	fi
Ver=`wget -qO- https://github.com/ginuerzh/gost/releases/latest | grep "css-truncate-target" | awk '{print $2}' | sed 's/class=\"css-truncate-target\">//g' | sed 's/<\/span>//g'`
Vernv=`echo ${Ver} | sed 's/v//'`
wget https://github.com/ginuerzh/gost/releases/download/${Ver}/gost_${Vernv}_linux_amd64.tar.gz
tar -zxf gost_${Vernv}_linux_amd64.tar.gz
cp gost_${Vernv}_linux_amd64/gost /usr/bin/gost
rm -rf gost_${Vernv}_linux_amd64*
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
IP=$(ip a|grep -w 'inet'|grep 'global'|sed 's/^.*inet //g'|sed 's/\/[0-9][0-9].*$//g')
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

start
esac
fi
