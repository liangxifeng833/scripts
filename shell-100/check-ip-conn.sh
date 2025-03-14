#!/bin/bash
##############################################################
# File Name:check-ip-conn.sh
# Author:liangxifeng
# Desc:检查外部有多少个主机正在连接本地主机 
# Date:2025.03.14
##############################################################
#引入函数库
. `echo $MY_FUNCTION`
#ssh 22 端口连接数量
#sshCount=`ss -ant | grep -i ESTAB | wc -l | awk '$4~/:22$/'`
#当前登录用户列表
loginUser=`who | awk '{ if($5=="") $5="本地主机登录"; print $1,$5}'  | sed 's#[()]##g'`
#当前登录用户数
loginUserCount=`who | awk '{ if($5=="") $5="本地主机登录"; print $1,$5}'  | sed 's#[()]##g' | wc -l`
cat <<EOF
当前有 ${loginUserCount} 个用户登录该该主机,分别是：
$loginUser
EOF
