cd /home/ubuntu/stellar/
source .env.tmp
export PATH=$PATH:/home/ubuntu/horizon-v0.15.4-linux-amd64
horizon db init
horizon serve