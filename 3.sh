sudo apt update && sudo apt -y upgrade
cd ~/
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

# Get the bootstrap, remove default files then extract thbootstrap
cd ~/.Linda
wget https://transfer.sh/fNj2o/linda-v2-bootstrap-2018-04-29.tar.gz
rm -rf database txleveldb blk0001.dat peers.dat
tar xvf linda-v2-bootstrap-2018-04-26.tar.gz

# Move the Lind.conf file and promot user finalise with their details
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
echo "Perform by yourself: cd ~/"
echo "before you continue"
echo " "
echo " "
echo " "
echo " "
echo " "
