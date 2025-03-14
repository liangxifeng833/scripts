#!/bin/bash
##############################################################
# File Name:10-for-touch-file.sh
# Author:liangxifeng
# Desc: 生成10个随机命名的文件 
# Date:2025.03.11
##############################################################

dir="/lxf/"
#目录不存在则创建
if [ ! -d ${dir} ]; then
    mkdir ${dir}
fi

#循环10次
for n in {1..10}
do
    suiji=`mkpasswd -l 10 -s 0`
    fileName=${suiji}_lxf.html
    touch ${dir}${fileName}
done
