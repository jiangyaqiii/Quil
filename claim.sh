source /root/.gvm/scripts/gvm
gvm use go1.20.2
cd /root/ceremonyclient/client
GOEXPERIMENT=arenas go build -o qclient main.go
./qclient cross-mint $stringg
