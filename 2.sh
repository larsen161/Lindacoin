cd ~/
# Install and configure the machines firewall
sudo apt-get install ufw
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw allow 33820
sudo ufw enable

# Install any additional updates and reboot
sudo apt update && sudo apt -y upgrade
echo " "
echo " "
echo " "
echo " "
echo " "
echo "VPS will reboot automatically now!"
echo " "
echo " "
echo " "
echo " "
echo " "
reboot now
