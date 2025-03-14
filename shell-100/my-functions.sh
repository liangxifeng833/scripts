#!/bin/bash
##############################################################
# File Name:my-functions.sh
# Author:liangxifeng
# Desc: 自定义常用函数库 
# Date:2025.03.12
##############################################################
#红色
readEcho() {  
    #以下等效于：echo -e "\e[5;31m $@ \e[0m"
    echo -ne "\e[5;31m"
    echo -n "$@"
    echo -e "\e[0m"
}
#绿色
greenEcho() {  
    echo -ne "\e[1;32m"
    echo -n "$@"
    echo -e "\e[0m"
}
#蓝色
blueEcho() {  
    echo -ne "\e[1;34m"
    echo -n "$@"
    echo -e "\e[0m"
}
checkReturn() {
    if [ $? -eq 0 ];then
        greenEcho  命令执行成功
    else    
        readEcho 命令执行失败
    fi
}
