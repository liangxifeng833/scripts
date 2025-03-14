#!/bin/bash
##############################################################
# File Name:14-calc-pingjun.sh
# Author:liangxifeng
# Desc:  读取用户输入的10个数字，然后计算总和，平均值
# Date:2025.03.12
##############################################################

#脚本名_脚本执行的pid ,该文件用于存放用户输入的所有数字，每个数字1行存储
tmpFile=${0}_$$.txt
#tmpFile=${0}.txt
#检查参数
function checkParam()
{
    if [ "${num}" = "q" ]
    then
        echo "输入完成，准备进行计算"
        break
    fi

    if [[ ! ${num} =~ ^[0-9]+$ ]]; then
        echo "您输入的不是数字" 
        continue
    fi
}

#死循环读取用户输入，按下q键退出
function readNum() {
    while :
    do
        read -p "请输入数字,按q键结束输入:" num
        #调用验证参数函数
        checkParam
        echo ${num} >> $tmpFile
    done
}

#计算总和，平均值
function calcNum() {
    #将文件中的数据读到数组中
    numArr=(`cat $tmpFile`)
    sum=0 #总和
    for n in ${numArr[@]}
    do
        let sum=sum+n;
    done
    #平均数
    pingjun=`echo "${sum}/${#numArr[@]}" | bc -l`
    clear #清屏
    echo "输入的数是= ${numArr[@]}"
    echo "总和=${sum}"
    echo "平均数=${pingjun}"
}

readNum
calcNum
