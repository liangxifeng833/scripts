#!/bin/bash
#########################
# desc : 生成Systemd服务脚本
# date : 2025-03-25
#########################

#创建mysql配置文件
# $1 mysql配置文件名
# $2 basedir mysql基础目录
# $3 datadir mysql数据目录
function createSystemdService()
{
serviceFile="/etc/systemd/system/mysql.service"
if [ -e $serviceFile ] ;then
	echo "Systemed 服务配置文件 ${serviceFile} 已存在"
	exit 20
fi
cat > $serviceFile << EOF
[Unit]
Description=MySQL Server
After=network.target

[Service]
User=mysql
Group=mysql
Type=forking
PIDfile=${3}/mysqld.pid
TimeoutSec=0

ExecStart=${2}/bin/mysqld  --defaults-file=${1} --pid-file=${3}/mysqld.pid --daemonize \$MYSQLD_OPTS
ExecStop=/usr/local/mysql/bin/mysqladmin -u root -p shutdown

limitNOFILE = 65535
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF
}
#basedir="/usr/local/mysql" 	#mysql基础目录
#datadir="/data/mysql/3306/data" #mysql数据目录
#configFile="/etc/my.cnf"
#createSystemdService $configFile $basedir $datadir
