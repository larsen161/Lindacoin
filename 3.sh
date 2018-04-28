cd ~/
wget https://github.com/Lindacoin/Linda/releases/download/2.0.0.1/Unix.Lindad.v2.0.0.1g.tar.gz
curl -L https://www.dropbox.com/sh/0s9apwcl0uhlpmy/AABysrq0PEosSaHQKGyxCTioa?dl=1 > LindaBootstrap.zip
tar -xzvf Unix.Lindad.v2.0.0.1g.tar.gz -C /usr/local/bin/
Lindad -daemon
echo " "
echo " "
echo " "
echo " "
echo " "
echo "NerdyUser: Masternode started for 30 seconds, will be automatic stopped & script will continue!"
echo " "
echo " "
echo " "
echo " "
echo " "
sleep 30
Lindad stop

# Remove default files and extract the bootstrap
cd ~/.Linda
rm -rf database txleveldb blk0001.dat peers.dat
unzip ~/LindaBootstrap.zip -d ~/.Linda
rm ~/.Linda/autoBootstrap.cmd

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
echo "NerdyUser: Setup Complete"
echo " "
echo " "
echo " "
echo " "
echo " "
echo "NerdyUser: Perform by yourself: cd ~/"
echo "NerdyUser: before you continue"
echo " "
echo " "
echo " "
echo " "
echo " "
