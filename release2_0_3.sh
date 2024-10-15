sudo systemctl stop quili_monitor.service
screen -X -S Quili quit

cd ~/ceremonyclient/node

RELEASE_FILES_URL="https://releases.quilibrium.com/release"
OS_ARCH=linux-amd64
RELEASE_FILES=$(curl -s $RELEASE_FILES_URL | grep -oE "node-[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+-${OS_ARCH}(\.dgst)?(\.sig\.[0-9]+)?")
for file in $RELEASE_FILES; do
    wget "https://releases.quilibrium.com/$file"
done
chmod +x node-2*

#手动下载更新quil qclient二进制文件
cd ~/ceremonyclient/client/
RELEASE_FILES_URL="https://releases.quilibrium.com/qclient-release"
OS_ARCH=linux-amd64
RELEASE_FILES=$(curl -s $RELEASE_FILES_URL | grep -oE "qclient-[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+-${OS_ARCH}(\.dgst)?(\.sig\.[0-9]+)?")
for file in $RELEASE_FILES; do
    wget "https://releases.quilibrium.com/$file"
done
chmod +x qclient-2*

# ===================================公共模块===监控screen模块======================================================================
cd ~
#监控screen脚本
echo '#!/bin/bash
while true
do
    if ! screen -list | grep -q "Quili"; then
        echo "Screen session not found, restarting..."
        cd /root/ceremonyclient/node
        screen -d -m -S Quili bash -c "./node-2.0.0.3-linux-amd64"
    fi
    sleep 10  # 每隔10秒检查一次
done' > monit.sh
##给予执行权限
chmod +x monit.sh
# ================================================================================================================================
echo '==flag:v200=='
sudo systemctl start quili_monitor.service
##删除此文件
cd ~
rm -f release2_0_3.sh
