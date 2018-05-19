#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

#=================================================
#	System Required: CentOS 6+/Debian 6+/Ubuntu 14.04+
#	Description: Test the vps and install the software
#	Version: 0.0.1
#	Author: VPSBASH
#	Email: VPSBASH@GMAIL.COM
#	#Scripts copy from the big guys
#=================================================

sh_ver="0.0.1"
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

ZBench_1() {
	wget -N --no-check-certificate https://vpsbash.github.io/ZBench.sh && bash ZBench.sh
    rm -rf ZBench.sh
	exit 0
}
ZBench_2() {
	wget -N --no-check-certificate https://vpsbash.github.io/ZBench-CN.sh && bash ZBench-CN.sh
    rm -rf ZBench-CN.sh
	exit 0
}
ZBench_3() {
	wget -N --no-check-certificate https://raw.githubusercontent.com/FunctionClub/ZBench/master/ZBench.sh && bash ZBench.sh
    rm -rf ZBench.sh
	exit 0
}
ZBench_4() {
	wget -N --no-check-certificate https://raw.githubusercontent.com/FunctionClub/ZBench/master/ZBench-CN.sh && bash ZBench-CN.sh
    rm -rf ZBench-CN.sh
	exit 0
}
ZBench() {
echo && echo -e "版本选择
 ${Green_font_prefix}1.${Font_color_suffix} ZBench_EN去除上传版本
 ${Green_font_prefix}2.${Font_color_suffix} ZBench_CN去除上传版本
 ${Green_font_prefix}3.${Font_color_suffix} ZBench_EN默认版本
 ${Green_font_prefix}4.${Font_color_suffix} ZBench_CN默认版本
" && echo
stty erase '^H' && read -p "(默认: 取消):" other_num
	[[ -z "${other_num}" ]] && echo "已取消..." && exit 0
	if [[ ${other_num} == "1" ]]; then
		ZBench_1
	elif [[ ${other_num} == "2" ]]; then
		ZBench_2
	elif [[ ${other_num} == "3" ]]; then
		ZBench_3
	elif [[ ${other_num} == "4" ]]; then
		ZBench_4
	else
		echo -e "${Error} 请输入正确的数字 [1-4]" && exit 0
    fi
}


TestYourVPS_1(){
    wget -qO- --no-check-certificate https://raw.githubusercontent.com/SunsetLast/TestYourVPS/master/test-en.sh | bash test-en.sh 
	exit 0
}

TestYourVPS_2(){
    wget -qO- --no-check-certificate https://raw.githubusercontent.com/SunsetLast/TestYourVPS/master/test.sh | bash test.sh 
	exit 0
}

TestYourVPS(){
echo && echo -e "版本选择
 ${Green_font_prefix}1.${Font_color_suffix} TestYourVPS英文版
 ${Green_font_prefix}2.${Font_color_suffix} TestYourVPS中文版
" && echo
stty erase '^H' && read -p "(默认: 取消):" other_num
	[[ -z "${other_num}" ]] && echo "已取消..." && exit 0
	if [[ ${other_num} == "1" ]]; then
		TestYourVPS_1
	elif [[ ${other_num} == "2" ]]; then
		TestYourVPS_2
	else
		echo -e "${Error} 请输入正确的数字 [1-2]" && exit 0
    fi
}

Superbench_1(){
wget -qO- git.io/superbench.sh | bash
exit 0
}

Superbench_2(){
wget -qO- git.io/superbench_old.sh | bash
exit 0
}

Superspeed_1(){
wget https://raw.githubusercontent.com/oooldking/script/master/superspeed.sh && chmod +x superspeed.sh && ./superspeed.sh
rm -rf superspeed.sh
exit 0
}

Superbench(){
echo && echo -e "版本选择
 ${Green_font_prefix}1.${Font_color_suffix} Superbench新版
 ${Green_font_prefix}2.${Font_color_suffix} Superbench旧版
 ${Green_font_prefix}3.${Font_color_suffix} Superspeed古董版
" && echo
stty erase '^H' && read -p "(默认: 取消):" other_num
	[[ -z "${other_num}" ]] && echo "已取消..." && exit 0
	if [[ ${other_num} == "1" ]]; then
		Superbench_1
	elif [[ ${other_num} == "2" ]]; then
		Superbench_2
	elif [[ ${other_num} == "3" ]]; then
		Superspeed_1
	else
		echo -e "${Error} 请输入正确的数字 [1-3]" && exit 0
    fi
}

Bench_1(){
wget -qO- bench.sh | bash
exit 0
}

Bench(){
echo && echo -e "版本选择
 ${Green_font_prefix}1.${Font_color_suffix} Bench传统脚本
 ${Green_font_prefix}2.${Font_color_suffix} 退出脚本
" && echo
stty erase '^H' && read -p "(默认: 取消):" other_num
	[[ -z "${other_num}" ]] && echo "已取消..." && exit 0
	if [[ ${other_num} == "1" ]]; then
		Bench_1
	elif [[ ${other_num} == "2" ]]; then
		exit 0
	else
		echo -e "${Error} 请输入正确的数字 [1-3]" && exit 0
    fi
}

Unixbench_1(){
wget --no-check-certificate https://github.com/teddysun/across/raw/master/unixbench.sh
chmod +x unixbench.sh
./unixbench.sh
rm -rf unixbench.sh
exit 0
}

Unixbench(){
echo && echo -e "版本选择
 ${Green_font_prefix}1.${Font_color_suffix} Unixbench传统脚本
 ${Green_font_prefix}2.${Font_color_suffix} 退出脚本
" && echo
stty erase '^H' && read -p "(默认: 取消):" other_num
	[[ -z "${other_num}" ]] && echo "已取消..." && exit 0
	if [[ ${other_num} == "1" ]]; then
		Unixbench_1
	elif [[ ${other_num} == "2" ]]; then
		exit 0
	else
		echo -e "${Error} 请输入正确的数字 [1-3]" && exit 0
    fi
}

VPS_TEST(){
echo && echo -e "你要测试什么脚本? ${Red_font_prefix}${Font_color_suffix}
 ${Green_font_prefix}1.${Font_color_suffix} ZBench
 ${Green_font_prefix}2.${Font_color_suffix} TestYourVPS
 ${Green_font_prefix}3.${Font_color_suffix} Superbench
 ${Green_font_prefix}4.${Font_color_suffix} Bench
 ${Green_font_prefix}5.${Font_color_suffix} Unixbench
" && echo
stty erase '^H' && read -p "(默认: 取消):" other_num
	[[ -z "${other_num}" ]] && echo "已取消..." && exit 0
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
		echo -e "${Error} 请输入正确的数字 [1-5]" && exit 0
	fi
}

echo -e " VPS一键管理脚本 ${Red_font_prefix}[v${sh_ver}]${Font_color_suffix}
  ${Green_font_prefix}1.${Font_color_suffix} VPS测试
  ${Green_font_prefix}2.${Font_color_suffix} 退出脚本
 "
	echo && stty erase '^H' && read -p "请输入数字 [1-2]：" num
case "$num" in
	1)
	VPS_TEST
	;;
	2)
	exit 0
	;;
	*)
	echo -e "${Error} 请输入正确的数字 [1-2]" && exit 0
	;;
esac
fi
