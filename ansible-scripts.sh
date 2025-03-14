#!/bin/bash
#desc:ansible测试脚本
#author:liangxifeng 2025-01-13

echo "主机名: $(hostname)" 
echo "ip地址:$(hostname -I)"
echo "系统时间和负载:$(uptime)"
echo "登录用户名: $(whoami)"
echo "时间: $(date +%F)"
sleep 10
