#!/bin/bash
##############################################################
# File Name:13-fang-dos.sh
# Author:liangxifeng
# Desc: 分析nginx访问日志，找出ip方法最多的前5条，添加防火墙将其屏蔽 
# Date:2025.03.12
##############################################################

#1. 定义变量
accessLog='access.log'  #nginx日志文件
resultFile='result.txt' #找出访问最多的前五ip地址，放入到该文件

#2.日志分析，找出访问最多的前五个ip 重定向到 result.txt中
awk '{print $1}' access.log | sort | uniq -c | sort -rn | head -5 > result.txt

#3.进行处理
while read line
do
    #ip数量
    ipCount=`echo ${line} | awk '{print $1}'`
    #ip地址
    ipAddress=`echo ${line} | awk '{print $2}'`
    #echo ${ipCount} ---- ${ipAddress}
    #进行判断,请求数>=200的，iptables中对于该ip没有规则的，加入防火墙中并DROP
    if  [ $ipCount -ge 200 -a `iptables -nL |grep -wc "${ipAddress}"` -eq 0 ]
    then
        iptables -t filter -I INPUT -s ${ipAddress} -j DROP
    fi
done <result.txt
