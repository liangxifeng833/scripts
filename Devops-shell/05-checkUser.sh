#!/bin/bash
##############################################################
# File Name:05-checkUser.sh
# Author:liangxifeng
# Desc: 检查用户是否存在，并且输出用户相关信息 
# Date:2025.03.09
##############################################################

#1. 变量
read -p "请输入用户名" user

#2. 判断用户是否存在
[ "${user}x" = "x" ] && {
   echo "用户:${user}, 不存在！" 
   exit 1
}
id $user &>/dev/null
[ $? -ne 0 ] && {
   echo "用户:${user}, 不存在！" 
   exit 1
} 

#2.获取用户登录情况
user_shell=`grep "^${user}:" /etc/passwd | awk -F':' '{print $NF}'`
if [ "${user_shell}" = "/bin/bash" ]; then
    user_login="可以登录";
else
    user_login="不可以登录";
fi
#获取用户uid,gid,家目录,最近一次登录情况
uid=`grep "^${user}:" /etc/passwd | awk -F':' '{print $3}'`
gid=`grep "^${user}:" /etc/passwd | awk -F':' '{print $4}'`
homeDir=`grep "^${user}:" /etc/passwd | awk -F':' '{print $(NF-1)}'`
lastLog=`lastlog | grep -w "${user}"`

cat <<EOF
用户名: $user
是否可以登录: $user_login
用户uid: $uid
用户gid: $gid
用户家目录: $homeDir
用户最近一次登录情况: $lastLog
EOF
