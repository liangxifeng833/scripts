#!/bin/bash
##############################################################
# File Name:12-while-read.sh
# Author:liangxifeng
# Desc: 
# Date:2025.03.12
##############################################################
file=num.txt
i=0;
while read line
do
    echo $line
    let i++
done <$file
echo "这个文件一共有${i}行"
