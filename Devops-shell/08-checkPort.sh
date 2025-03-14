#!/bin/bash
##############################################################
# File Name:08-checkPort.sh
# Author:liangxifeng
# Desc: 检查某个主机某个端口是否可以访问
# Date:2025.03.11
##############################################################
#1.接收参数
host=$1
port=$2
#加载函数库
. /etc/init.d/functions

# $1 脚本的参数个数
# $2 port 端口
function checkParam()
{
    #参数必须是2个
    [ $1 -ne 2 ] && {
        action "参数必须是2个，主机和端口" /bin/false
        return 1;
    }
    #端口号必须是数字
    [[ $2 =~ ^[0-9]+$ ]] || {
        action "端口号必须是数字" /bin/false
        return 2;
    }
}

#正式检查 端口是否通
function checkPort()
{
    portCount=`nmap -p ${port} ${host} | grep -w open |wc -l`
    if [ $portCount -eq 1 ]; then
        action "${host} ${port} 是通畅的" /bin/true
        return 3
    else
        action "${host} ${port} 是不通畅的" /bin/false
        return 4
    fi
}

#1.验证参数
checkParam $# $port
[ $? -ne 0 ] && exit $?;

#2.检查端口
checkPort
