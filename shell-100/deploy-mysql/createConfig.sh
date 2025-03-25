#!/bin/bash
#########################
# desc : 创建mysql配置文件my.cnf
# date : 2025-03-25
#########################

#创建mysql配置文件
# $1 配置文件名
# $2 basedir mysql基础目录
# $3 datadir mysql数据目录
function createConfig()
{
if [ -e $1 ] ;then
	echo "Mysql配置文件$1 已存在"
	exit 2
fi
cat > $1 << EOF
[client]
socket=${3}/mysql.sock

[mysqld]
basedir = $2
datadir=$3
user = mysql
port = 3306
socket=${3}/mysql.sock
log_error = ${3}/mysqld.err

log-bin = mysql-bin
server-id = 1
EOF
}
