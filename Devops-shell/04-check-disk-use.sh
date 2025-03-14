#!/bin/bash
##############################################################
# File Name:04-check-disk-use.sh
# Author:liangxifeng
# Desc: 验证硬盘使用率 
# Date:2025.03.09
##############################################################

#1. 定义变量
error=80
#获取根目录/使用率
root_usage=`df -h | grep -w / | awk -F '[ %]+' '{print $(NF-1)}' `

#2.判断
if [ $root_usage -gt $error ]; then
    echo "根目录/使用率已超过80%"
else
    echo "磁盘空间正常"
fi
