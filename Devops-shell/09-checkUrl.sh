#!/bin/bash
##############################################################
# File Name:09-checkUrl.sh
# Author:liangxifeng
# Desc: 检查url地址是否可以访问
# Date:2025.03.11
##############################################################
#接收参数
url=$1
#加载函数库
. /etc/init.d/functions

# $1 脚本的参数个数
function checkParam()
{
    #参数必须是2个
    [ $1 -ne 1 ] && {
        action "参数必须是1个url地址" /bin/false
        return 1;
    }
    #验证url格式
    [[ $url =~ ^[0-9a-zA-Z./:]+$ ]] || {
        action "url地址格式错误" /bin/false
        return 2;
    }
}

#检查url是否可以访问
function checkUrl() 
{
    urlState=`curl -s -I ${url} | awk 'NR==1 {print $2}'`;
    #如果状态码=空
    [ -z "$urlState" ] && {
        action "该url ${url} 不能访问" /bin/false
        exit 3
    }
    echo $urlState
    #状态码=200/301/302 都代表该地址可以访问
    if [ ${urlState} -eq 200 -o ${urlState} -eq 301 -o ${urlState} -eq 302 ];then
        action "该url ${url} 可以访问" /bin/true
    else
        action "该url ${url} 不能访问" /bin/false
        exit 4 
    fi
}
#验证参数
checkParam $#
[ $? -ne 0 ] && exit $?;
#执行验证url
checkUrl
