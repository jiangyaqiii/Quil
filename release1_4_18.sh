screen -X -S Quili quit
cd ~/ceremonyclient
git pull
git switch release
cd ~/ceremonyclient/node
screen -dmS Quili bash -c './release_autorun.sh'

##删除此文件
cd ~
rm -f release1_4_18.sh
