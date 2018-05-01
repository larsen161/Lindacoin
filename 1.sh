cd ~/
sudo apt-get update && sudo apt-get -y upgrade
sleep 5
sudo fallocate -l 3G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo echo -e "/swapfile none swap sw 0 0 \n" >> /etc/fstab
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
sudo reboot now
