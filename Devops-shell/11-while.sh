#!/bin/bash
##############################################################
# File Name:11-while.sh
# Author:liangxifeng
# Desc: 
# Date:2025.03.12
##############################################################

i=1
sum=0
while [ $i -le 10 ]
do
    #echo $i
    let sum=sum+i
    let i++
done
echo $sum

#生成1~4随机数
random=$(( $RANDOM%3 + 1 ))
j=0;
while :
do
    let j++
    read -p "请输入数字:"  num
    [[ ${num} =~ ^[0-9]+$ ]] || {
        echo "您输入的不是数字"
        continue
    }
    if [ ${num} -gt ${random} ];then
        echo "输入的数字大了！"
    elif [ ${num} -lt ${random} ];then
        echo "输入的数字小了！"
    else
        echo "恭喜您，猜对了,共猜了${j}次"
        exit 0;
    fi
done

