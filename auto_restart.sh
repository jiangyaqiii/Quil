systemctl stop quili_monitor.service
pkill screen

# ===================================公共模块===监控screen模块======================================================================
cd ~
#监控screen脚本
echo '#!/bin/bash
while true
do
    if ! screen -list | grep -q "quili"; then
        echo "Screen session not found, restarting..."
        cd /root/ceremonyclient/node
        screen -dmS quili bash -c ' ./node-2.0.1-linux-amd64'
    fi
    sleep 10  # 每隔10秒检查一次
done' > monit.sh
##给予执行权限
chmod +x monit.sh
# ================================================================================================================================
echo '[Unit]
Description=Quili Monitor Service
After=network.target

[Service]
Type=simple
ExecStart=/bin/bash /root/monit.sh

[Install]
WantedBy=multi-user.target' > /etc/systemd/system/quili_monitor.service
sudo systemctl daemon-reload
sudo systemctl enable quili_monitor.service
sudo systemctl start quili_monitor.service
sudo systemctl status quili_monitor.service
