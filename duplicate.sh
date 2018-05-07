# Linda -datadir Configuration
mv .Linda .Linda00
mv ~/.Linda00/wallet.dat ~/.Linda00/wallet00.dat
cp -R .Linda00 .Linda01
cp -R .Linda00 .Linda02
rm ~/.Linda01/wallet00.dat ~/.Linda02/wallet00.dat

# Lindad configuration
sudo mv /usr/local/bin/Lindad /usr/local/bin/Lindad00
sudo cp /usr/local/bin/Lindad00 /usr/local/bin/Lindad01
sudo cp /usr/local/bin/Lindad00 /usr/local/bin/Lindad02

