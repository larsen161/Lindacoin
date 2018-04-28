cd ~/
apt-get update
sleep 5
apt-get upgrade
sleep 5
fallocate -l 3G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
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
reboot