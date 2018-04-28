cd /root/
wget https://github.com/Lindacoin/Linda/releases/download/2.0.0.1/Unix.Lindad.v2.0.0.1g.tar.gz
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
cd /root/
sudo nano ~/.Linda/Linda.conf
echo " "
echo " "
echo " "
echo " "
echo " "
echo "NerdyUser: Part 3 completed, go to step: sh 4.sh!"
echo " "
echo " "
echo " "
echo " "
echo " "