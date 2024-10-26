#!/bin/bash

systemctl stop quili_monitor.service
pkill screen

cd /root/ceremonyclient/node

# 获取并下载最新的 linux-amd64 文件
for f in $(curl -s https://releases.quilibrium.com/release | grep linux-amd64); do
    echo "Processing $f..."
    
    # 如果文件存在，删除它
    if [ -f "$f" ]; then
        echo "Removing existing file: $f"
        rm "$f"
    fi
    
    # 下载文件
    echo "Downloading $f..."
    curl -s -O "https://releases.quilibrium.com/$f"
done
chmod +x node-2*


cd /root/ceremonyclient/client
# 获取并下载最新的 linux-amd64 文件
for f in $(curl -s https://releases.quilibrium.com/qclient-release | grep linux-amd64); do
    echo "Processing $f..."
    
    # 如果文件存在，删除它
    if [ -f "$f" ]; then
        echo "Removing existing file: $f"
        rm "$f"
    fi
    
    # 下载文件
    echo "Downloading $f..."
    curl -s -O "https://releases.quilibrium.com/$f"
done
chmod +x qclient-2*

cd /root/ceremonyclient/node
screen -dmS quili bash -c ' ./node-2.0.2.1-linux-amd64'

# ===================================公共模块===监控screen模块======================================================================
# cd ~
# #监控screen脚本
# echo '#!/bin/bash
# while true
# do
#     if ! screen -list | grep -q "quili"; then
#         echo "Screen session not found, restarting..."
#         cd /root/ceremonyclient/node
#         screen -dmS quili bash -c ' ./node-2.0.2-linux-amd64'
#     fi
#     sleep 10  # 每隔10秒检查一次
# done' > monit.sh
# ##给予执行权限
# chmod +x monit.sh
# # ================================================================================================================================
# echo '[Unit]
# Description=Quili Monitor Service
# After=network.target

# [Service]
# Type=simple
# ExecStart=/bin/bash /root/monit.sh

# [Install]
# WantedBy=multi-user.target' > /etc/systemd/system/quili_monitor.service
# sudo systemctl daemon-reload
# sudo systemctl enable quili_monitor.service
# sudo systemctl start quili_monitor.service
# sudo systemctl status quili_monitor.service

