#!/bin/bash
##############################################################
# File Name:03-calc.sh
# Author:liangxifeng
# Desc: 简单版计算器 
# Date:2025.03.09
##############################################################

#1.接收参数
num1=$1
num2=$2
#2.验证
if [ $# -ne 2 ];then
    echo "错误，必须提供2个参数"
    exit 1;
fi

#判断整数
#expr $num1 + $num2 + 666 &> /dev/null
#if [ $? -ne 0 ];then
#    echo "Usage: $0 数字1 数字2"
#    echo "2个参数必须是数字";
#    exit 2;
#fi

#判断小数，如果用正则，必须使用2个中括号
[[ $num1 =~ ^-?[0-9]+$ ]] || {
    echo "$num1 必须是数字"
    exit 2;
}

#3.计算
plus=`awk -vn1=$num1 -vn2=$num2 'BEGIN{print n1+n2 }'`
jian=`awk -vn1=$num1 -vn2=$num2 'BEGIN{print n1-n2 }'`
cheng=`awk -vn1=$num1 -vn2=$num2 'BEGIN{print n1*n2 }'`
chu=`awk -vn1=$num1 -vn2=$num2 'BEGIN{print n1/n2 }'`
#4.输出结果
cat <<EOF
计算$num1 + $num2 = ${plus}
计算$num1 - $num2 = $jian
计算$num1 * $num2 = $cheng
计算$num1 / $num2 = $chu
EOF
