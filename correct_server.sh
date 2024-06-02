screen -X -S Quili quit
service ceremonyclient stop

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
echo "================修正服务版本================"
echo "================上版本更新内容================"
echo "================flag:v3================"
echo "1、git仓库地址发生了变化"
echo ""
echo "2、更新到p2挖矿版本，由于每一个线程都会单启一个挖矿程序，单核会用2G左右内存，会导致内存溢出，此次更新限制了quil程序使用的核数"
echo ""
echo "================本次更新内容================"
echo "3、新增cpulimit，无需手动限制内核数，不安装无法正常运行"
echo ""
echo "================请注意================"
echo "请注意，此版本为仍为限制版本，由手动限制改为了官方限制"
echo ""
echo "已经启动quil程序,当前版本号为： Quilibrium Node - v1.4.18-p2 – Nebula"
