# Install and configure the machines firewall
sudo apt-get install fail2ban

# Install any additional updates
sudo apt update && sudo apt upgrade -y

# Get the Linda binanry and extract
wget https://github.com/Lindacoin/Linda/releases/download/2.0.0.1/Unix.Lindad.v2.0.0.1g.tar.gz
tar -xzvf Unix.Lindad.v2.0.0.1g.tar.gz -C /usr/local/bin/
Lindad -daemon
echo " "
echo " "
echo " "
echo " "
echo " "
echo "Masternode started for 30 seconds, will be automatic stopped & script will continue!"
echo " "
echo " "
echo " "
echo " "
echo " "
sleep 30
Lindad stop

# Get the bootstrap, remove default files then extract the bootstrap
cd ~/.Linda
wget -O bootstrap.tar.gz https://transfer.sh/bqhDi/linda-v2-bootstrap-2018-05-07.tar.gz 
rm -rf database txleveldb blk0001.dat peers.dat
tar xvf bootstrap.tar.gz

# Generate random rpc credentials
rpcuser=$(date +%s | sha256sum | base64 | head -c 8)
rpcpassword=$(date +%s | sha256sum | base64 | head -c 20)

# Get server IP address
ipaddress=$(curl ipinfo.io/ip)

# Ask user for masternode genkey
echo -n "Enter your cold wallet genkey value & press Enter: "
read masternodegenkey

# Generate the Lind.conf file with saved variable
echo "rpcuser=${rpcuser}
rpcpassword=${rpcpassword}
rpcallowip=127.0.0.1
server=1
listen=1
daemon=1
logtimestamps=1
maxconnections=128
masternode=1
masternodeaddr=${ipaddress}:33820
masternodeprivkey=${masternodegenkey}
seednode=seed1.linda-wallet.com
seednode=seed2.linda-wallet.com
seednode=seed3.linda-wallet.com
seednode=seed4.linda-wallet.com
seednode=seed5.linda-wallet.com
seednode=seed6.linda-wallet.com
seednode=seed7.linda-wallet.com
seednode=seed8.linda-wallet.com
seednode=seed9.linda-wallet.com" > ~/.Linda/Linda.conf

# Cleanup steps
cd ~/
rm -rf Lindacoin
rm -rf https://github.com/Lindacoin/Linda/releases/download/2.0.0.1/Unix.Lindad.v2.0.0.1g.tar.gz
rm ~/bootstrap.tar.gz

# Run the Linda wallet, show Linda.conf
Lindad
echo " "
echo " "
echo " "
echo " "
echo " "
echo "Setup Complete"
echo "Confirm configuration viewing Linda.conf below"
echo " "
echo " "
echo " "
echo " "
echo " "
cat ~/.Linda/Linda.conf
