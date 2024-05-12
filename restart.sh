cd ~/ceremonyclient/node
git pull
pkill screen
gvm install go1.4 -B
gvm use go1.4
export GOROOT_BOOTSTRAP=$GOROOT
gvm install go1.17.13
gvm use go1.17.13
export GOROOT_BOOTSTRAP=$GOROOT
gvm install go1.20.2
gvm use go1.20.2
screen -dmS Quili bash -c './poor_mans_cd.sh'
