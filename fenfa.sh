#!/bin/bash
#desc:一键ssh密钥对,并将ssh公钥分发到其他主机
#date:2025-01-12
#author: liangxifeng

#1. 定义变量
#对方主机密码（多个主机尽量使用相同的密码）
pass=123456
#目标ip
#ips="10.0.0.31 10.0.0.41"
ips="10.0.0.7"

#引入函数库
. /etc/init.d/functions
#2. 创建密钥对
if [ -f ~/.ssh/id_rsa ] ;then
	echo "已存在密钥对"
else
	echo "正在创建密钥对..."
	ssh-keygen -t rsa  -f ~/.ssh/id_rsa   -P '' &>/dev/null
	if [$? -eq 0 ];then
		action "密钥创建成功" /bin/true
	else
		action "密钥创建失败" /bin/false
	fi
fi
#3.通过循环发送公钥
for ip in ${ips}
do
	sshpass -p${pass} ssh-copy-id -i ~/.ssh/id_rsa.pub -oStrictHostKeyChecking=no  ${ip} &>/dev/null
	if [ $? -eq 0 ];then
		action "${ip} 公钥分发成功" /bin/true
	else
		action "${ip} 公钥分发失败" /bin/false
	fi
done
