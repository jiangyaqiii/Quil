cd ~/ceremonyclient/node
# rm -rf .config
screen -X -S Quili quit
screen -dmS Quili bash -c " ./release_autorun.sh"
