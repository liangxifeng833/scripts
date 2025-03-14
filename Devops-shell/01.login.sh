#!/bin/bash
##############################################################
# File Name:01.login.sh
# Author:liangxifeng
# Desc: 登录主机后显示的内容
# Date:2025.02.19
##############################################################

#1.定义变量
hostname=`hostname`
ip=`hostname -I`
totalMemory=`free -h | awk 'NR==2{print $2}'`
keUseMemory=`free -h | awk 'NR==2{print $7}'`
sysLoad01=`w | awk -F'e:' 'NR==1{print $2}'`
sysLoad02=`uptime |sed 's#^.*age:##g'`
sysLoad03=`uptime |awk '{print  $(NF-2),$(NF-1),$NF}'`

#2.打印输出,其中系统负载01/02/03 输出结果一样, 只是3种不同写法而已
cat <<EOF
主机名: $hostname 
ip地址: $ip
总计内存: $totalMemory
可用内存: $keUseMemory
系统负载01: $sysLoad01
系统负载02: $sysLoad02
系统负载03: $sysLoad03
EOF
