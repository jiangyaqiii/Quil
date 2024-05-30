screen -X -S Quili quit

cd ~/ceremonyclient
git remote set-url origin https://source.quilibrium.com/quilibrium/ceremonyclient.git

cd ~/ceremonyclient/node 
# 赋予执行权限
chmod +x release_autorun.sh

##通过服务启动
echo '[Unit]
Description=Ceremony Client Go App Service

[Service]
Type=simple
Restart=always
RestartSec=5s
WorkingDirectory=/root/ceremonyclient/node
ExecStart=/root/ceremonyclient/node/release_autorun.sh
CPUQuota=700%

[Install]
WantedBy=multi-user.target' > /etc/systemd/system/ceremonyclient.service
systemctl daemon-reload
systemctl start ceremonyclient.service
# 删除你的 SELF_TEST 文件（这非常重要，如果你不这样做，你的节点可能会因作弊而被取消资格）
rm ~/ceremonyclient/node/.config/SELF_TEST
journalctl -u ceremonyclient.service -f -n 500
