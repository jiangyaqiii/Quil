sudo systemctl stop quili_monitor.service
screen -X -S Quili quit
cd ~/ceremonyclient
git pull
git switch v2.0.0-p3
cd ~/ceremonyclient/node
screen -X -S Quili quit
## screen -d -m -S Quili bash -c "./node-2.0.0.3-linux-amd64"
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
