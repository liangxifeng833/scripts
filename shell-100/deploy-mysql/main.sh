#!/bin/bash
#########################
# desc : 部署mysql服务脚本入口
# date : 2025-03-25
#########################

#引入生成my.cnf函数
. createConfig.sh 
#引入生成systemd服务脚本函数
. createSystemd.sh

basedir="/usr/local/mysql" 	#mysql基础目录
datadir="/data/mysql/3306/data" #mysql数据目录
configFile="/etc/my-3306.cnf" #mysql配置文件
[ -d ${datadir} ] || mkdir -p ${datadir}

cd /usr/local
softTar="mysql-8.0.35-linux-glibc2.12-x86_64.tar.xz" #软件包名称
#软件不存在则下载压缩包
[ -e $softTar ] || wget https://downloads.mysql.com/archives/get/p/23/file/${softTar}
if [ $? -ne 0 ];then 
    echo "Mysql二进制压缩包下载失败!"
    exit 1
fi
#解压缩并创建软连接
tar xf mysql-8.0.35-linux-glibc2.12-x86_64.tar.xz
ln -s mysql-8.0.35-linux-glibc2.12-x86_64 mysql

#创建mysql用户,并赋予数据目录权限
useradd -s /sbin/nologin -M mysql
chown -R mysql.mysql $datadir

#新建配置文件my.cnf
createConfig $configFile $basedir $datadir
[ $? -eq 0 ] && echo "${configFile} ----init success"

#初始化mysql
${basedir}/bin/mysqld --defaults-file=${configFile} --initialize-insecure
#echo "${basedir}/bin/mysqld --defaults-file=${configFile} --initialize-insecure"

if [ $? -ne 0 ];then
    echo "Mysql 初始化操作失败"
    exit 3
fi
#创建配置/etc/systemd/system/mysql.service服务文件
createSystemdService $configFile $basedir $datadir
[ $? -eq 0 ] && echo "/etc/systemd/system/mysql.service ---- init success"

#启动mysql服务
systemctl daemon-reload
systemctl enable mysql
systemctl start mysql

if [ $? -eq 0 ]; then
    echo "export PATH=\$PATH:${basedir}/bin" >> /etc/profile
    source /etc/profile
fi

[ $? -eq 0 ] && {
    echo "Mysql部署并启动成功"
    exit 0
}


