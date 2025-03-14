#!/bin/bash
##############################################################
# File Name:test.sh
# Author:liangxifeng
# Desc: test
# Date:2025.02.19
##############################################################

read -p "请输入任意信息：" str;
expr "$str" + 666 &>/dev/null
if [ $? -ne 0 ]; then
    echo "$str 不是数字!"
fi
