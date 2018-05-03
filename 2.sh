cd ~/
# Install and configure the machines firewall
sudo apt-get install ufw
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw allow 33820
sudo ufw enable

# Install any additional updates
sudo apt update && sudo apt -y upgrade

# Get the Linda binanry and extract
wget https://github.com/Lindacoin/Linda/releases/download/2.0.0.1/Unix.Lindad.v2.0.0.1g.tar.gz
tar -xzvf Unix.Lindad.v2.0.0.1g.tar.gz -C /usr/local/bin/
Lindad -daemon

# Generate and save the masternode privkey to a variable
sleep 15
masternodeprivkey=$(Lindad masternode genkey)

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
sleep 15
Lindad stop

# Get the bootstrap, remove default files then extract thbootstrap
cd ~/.Linda
wget https://transfer.sh/N4OpZ/linda-v2-bootstrap-2018-05-03.tar.gz 
rm -rf database txleveldb blk0001.dat peers.dat
tar xvf linda-v2-bootstrap-2018-05-03.tar.gz

# Generate random rpc credentials
rpcuser=$(date +%s | sha256sum | base64 | head -c 8)
rpcpassword=$(date +%s | sha256sum | base64 | head -c 20)

# Get server IP address
ipaddress=$(curl ipinfo.io/ip)

# Generate the Lind.conf file with saved variable
echo "rpcuser=${rpcuser}
rpcpassword=${rpcpassword}
rpcallowip=127.0.0.1
server=1
listen=1
daemon=1
logtimestamps=1
maxconnections=256
masternode=1
masternodeprivkey=${masternodegenkey}"
addnode=seed1.linda-wallet.com
addnode=seed2.linda-wallet.com
addnode=seed3.linda-wallet.com
addnode=seed4.linda-wallet.com
addnode=seed5.linda-wallet.com
addnode=seed6.linda-wallet.com
addnode=seed7.linda-wallet.com
addnode=seed8.linda-wallet.com
addnode=seed9.linda-wallet.com
addnode=seed10.linda-wallet.com
addnode=seed11.linda-wallet.com" > ~/.Linda/Linda.conf

mv ~/Lindacoin/Linda.conf ~/.Linda/Linda.conf
cd ~/
sudo nano ~/.Linda/Linda.conf

# Cleanup steps
cd ~/
rm -rf Lindacoin
rm -rf https://github.com/Lindacoin/Linda/releases/download/2.0.0.1/Unix.Lindad.v2.0.0.1g.tar.gz
rm ~/LindaBootstrap.zip

# Run the Linda wallet
Lindad
echo " "
echo " "
echo " "
echo " "
echo " "
echo "Setup Complete"
echo " "
echo " "
echo " "
echo " "
echo " "
