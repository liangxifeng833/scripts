
cd /usr/local
#下载压缩包
wget https://downloads.mysql.com/archives/get/p/23/file/mysql-8.0.35-linux-glibc2.12-x86_64.tar.xz
if [ $? -nq 0 ];then 
    echo "Mysql二进制压缩包下载失败!"
    exit 1
fi
#解压缩并创建软连接
tar xf mysql-8.0.35-linux-glibc2.12-x86_64.tar.xz
ln -s mysql-8.0.35-linux-glibc2.12-x86_64 mysql

basedir="/usr/local/mysql" 	#mysql基础目录
datadir="/data/mysql/3306/data" #mysql数据目录
configFile="/etc/my-3306.cnf"
[ -d ${datadir} ] || mkdir -p ${datadir}

#创建mysql用户,并赋予数据目录权限
useradd -s /sbin/nologin -M mysql
chown -R mysql.mysql $datadir

#新建配置文件my.cnf
. ./createConfig.sh 
createConfig $configFile $basedir $datadir
[ $? -eq 0 ] && echo "${configFile} ----init success"

#初始化mysql
${basedir}/bin/mysqld --defaults-file=/etc/my.cnf --initialize-insecure
if [ $? -nq 0 ];then
{
    echo "Mysql 初始化操作失败"
    exit 3
}
#创建配置/etc/systemd/system/mysql.service服务文件
. ./createSystemd.sh
createSystemdService $configFile $basedir $datadir
[ $? -eq 0 ] && echo "/etc/systemd/system/mysql.service ---- init success"

#启动mysql服务
systemctl daemon-reload
systemctl enable mysql
systemctl start mysql

[ $? -eq 0 ] && {
    echo "Mysql部署并启动成功"
    exit 0
}


