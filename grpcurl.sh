echo ''
echo '将go加入全局环境'
source /root/.gvm/scripts/gvm
gvm install go1.4 -B
gvm use go1.4
export GOROOT_BOOTSTRAP=$GOROOT
gvm install go1.17.13
gvm use go1.17.13
export GOROOT_BOOTSTRAP=$GOROOT
gvm install go1.20.2
gvm use go1.20.2
echo '查询go的版本号'
go version
echo ''
echo '安装grpcurl'
go install github.com/fullstorydev/grpcurl/cmd/grpcurl@latest
echo ''
echo '将listenGrpcMultiaddr和listenRESTMultiaddr写入配置文件'
sed -i 's|listenGrpcMultiaddr: ""|listenGrpcMultiaddr: "/ip4/127.0.0.1/tcp/8337"|' ./ceremonyclient/node/.config/config.yml
sed -i 's|listenRESTMultiaddr: ""|listenRESTMultiaddr: "/ip4/127.0.0.1/tcp/8338"|' ./ceremonyclient/node/.config/config.yml
echo ''
echo '杀死本次quil会话'
screen -X -S quili quit

cd /root/ceremonyclient/node
screen -dmS quili bash -c ' ./node-2.0.2.1-linux-amd64'
