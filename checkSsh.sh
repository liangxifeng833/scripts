#!/bin/bash
#desc: 批量在指定机器中使用ssh执行hostname命令
#author: liangxifeng
#date 2025-01-12

#ips="10.0.0.31 10.0.0.41"
ips="10.0.0.7"

for ip in ${ips}
do
	ssh $ip hostname
done
