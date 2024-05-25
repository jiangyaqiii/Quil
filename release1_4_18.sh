screen -X -S Quili quit
cd ~/ceremonyclient
git pull
git switch release
cd ~/ceremonyclient/node
screen -dmS Quili bash -c './release_autorun.sh'
