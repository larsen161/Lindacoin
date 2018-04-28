cd ~/
sudo apt-get install -y pkg-config
sleep 5
sudo apt-get -y install build-essential autoconf automake libtool libboost-all-dev libgmp-dev libssl-dev libcurl4-openssl-dev git
sleep 5
sudo add-apt-repository ppa:bitcoin/bitcoin
sleep 5
sudo apt-get update
sleep 5
sudo apt-get install libdb4.8-dev libdb4.8++-dev
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