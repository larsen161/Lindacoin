cd ~/
sudo apt-get -y install pkg-config
sleep 5
sudo apt-get -y install build-essential autoconf automake libtool libboost-all-dev libgmp-dev libssl-dev libcurl4-openssl-dev git
sleep 5
sudo add-apt-repository ppa:bitcoin/bitcoin
sleep 5
sudo apt-get update
sleep 5
sudo apt-get -y install libdb4.8-dev libdb4.8++-dev

# Install and configure the machines firewall
sudo apt-get install ufw
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw allow 33820
sudo ufw enable
echo " "
echo " "
echo " "
echo " "
echo " "
echo "NerdyUser: VPS will reboot automatically now!"
echo " "
echo " "
echo " "
echo " "
echo " "
sleep 10
reboot
