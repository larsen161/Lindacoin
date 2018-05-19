#!/bin/bash

# Get system updates
sudo apt-get update && sudo apt-get -y upgrade
sleep 5

# Set the default Lindad port
port=33820

# Check if a swap file exists and create if one doesn't exist
if free | awk '/^Swap:/ {exit !$2}'; then
    echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    echo "!                                                     !"
    echo "! 'Swap file already active, skippping swap creation' !"
    echo "!                                                     !"
    echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
else
    sudo fallocate -l 3G /swapfile
    sudo chmod 600 /swapfile
    sudo mkswap /swapfile
    sudo swapon /swapfile
    sudo echo -e "/swapfile none swap sw 0 0 \n" >> /etc/fstab
fi

temp_linda (){
  # Make the Linda folder and default files
  mkdir ~/.Linda
  touch ~/Linda.conf
  cat /dev/null > ~/Linda.conf
}

install_security () {
  # Install and configure the security
  sudo apt-get install fail2ban
}

install_linda () {
  # Get the Linda binanry and extract
  wget https://github.com/Lindacoin/Linda/releases/download/2.0.0.1/Unix.Lindad.v2.0.0.1g.tar.gz
  sudo tar -xzf Unix.Lindad.v2.0.0.1g.tar.gz -C /usr/local/bin/
}

install_bootstrap () {
  # Get the bootstrap, then extract the bootstrap
  cd ~/.Linda
  wget -O bootstrap.tar.gz https://transfer.sh/BajOc/linda-v2-bootstrap-2018-05-19.tar.gz
  tar xf bootstrap.tar.gz
}

generate_rpc () {
  # Generate random rpc credentials
  rpcuser=$(date +%s | sha256sum | base64 | head -c 8)
  rpcpassword=$(date +%s | sha256sum | base64 | head -c 20)
}

get_ip () {
  # Get server primary IPv4 address
  ipaddress=$(curl ipinfo.io/ip)
}

linda_conf_core () {
# Append info to a Lind.conf file
echo "rpcuser=${rpcuser}
rpcpassword=${rpcpassword}
rpcallowip=127.0.0.1
server=1
daemon=1
logtimestamps=1
maxconnections=128
"  >> ~/Linda.conf
}

linda_conf_listen_yes () {
# Append info to a Lind.conf file
echo "listen=1
"  >> ~/Linda.conf
}

linda_conf_listen_no () {
# Append info to a Lind.conf file
echo "listen=0
"  >> ~/Linda.conf
}

linda_conf_bind_lan () {
# Append info to a Lind.conf file
echo "bind=${ipv4lan}
" >> ~/Linda.conf
}

linda_conf_bind_ipv6 () {
# Append info to a Lind.conf file
echo "bind=${ipaddress}
" >> ~/Linda.conf
}

linda_conf_connect () {
# Append info to a Lind.conf file
echo "connect=${ipv4lan}
" >> ~/Linda.conf
}

linda_conf_seeds () {
# Append info to a Lind.conf file
echo "seednode=seed1.linda-wallet.com
seednode=seed2.linda-wallet.com
seednode=seed3.linda-wallet.com
seednode=seed4.linda-wallet.com
seednode=seed5.linda-wallet.com
seednode=seed6.linda-wallet.com
seednode=seed7.linda-wallet.com
" >> ~/Linda.conf
}

linda_conf_mn () {
# Append info to a Lind.conf file
echo "masternode=1
masternodeaddr=${ipaddress}:${port}
masternodeprivkey=${masternodegenkey}
" >> ~/Linda.conf
}

linda_conf_stake () {
# Append info to a Lind.conf file
echo "staking=1
" >> ~/Linda.conf
}

linda_startup () {
  # Add Lindad to startup if server is rebooted
  if [ -f /usr/local/bin/Lindad ]; then
   sed '$i<Lindad>!' >> /etc/rc.local
  fi
  if [ $counter != 0 ]; then
    sed '$i<Lindad0${counter}>!' >> /etc/rc.local
  fi
}

masternode_conf () {
echo "something here
" >> ~/.Linda/masternode.conf
}

bash_aliases () {
echo "
# Lindad0${counter}
alias init0${counter}='Lindad0${counter} -datadir=/root/.Linda0${counter} -wallet=wallet00.dat'
alias Lindad0${counter}='Lindad0${counter} -rpcuser=${rpcuser} -rpcpassword=${rpcpassword} -rpcport=${port}'
alias getinfo0${counter}='Lindad0${counter} -rpcuser=${rpcuser} -rpcpassword=${rpcpassword} -rpcport=${port} getinfo'
alias debug0${counter}='Lindad0${counter} -rpcuser=${rpcuser} -rpcpassword=${rpcpassword} -rpcport=${port} masternode debug'
alias addy0${counter}='Lindad0${counter} -rpcuser=${rpcuser} -rpcpassword=${rpcpassword} -rpcport=${port} listreceivedbyaddress 0 true'
alias stop0${counter}='Lindad0${counter} -rpcuser=${rpcuser} -rpcpassword=${rpcpassword} -rpcport=${port} stop'
" >> ~/.bash_aliases
source ~/.bashrc
}

linda_complete () {
  # Start Lindad and show user information about the wallet and block progress
  Lindad
  echo " "
  echo " "
  echo " "
  echo "************************************************"
  echo "*                                              *"
  echo "* 'Your Linda Server is now complete.'         *" 
  echo "* 'Please review the configuraiotn file below' *" 
  echo "* 'along with information about your wallet.'  *" 
  echo "*                                              *"
  echo "************************************************"
  echo " "
  echo " "
  sleep 10 
  cat ~/.Linda/Linda.conf
}

linda_showaddress () {
  echo " "
  echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
  echo " "
  echo " This is your default Linda address you can send coins to"
  echo " "
  Lindad listreceivedbyaddress 0 true
  echo " "
}

linda_showblocks () {
  echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
  echo " "
  echo " Your wallet is currently sync'd up to this block"
  echo " To find the latest block, look for Current block at"
  echo " https://prohashing.com/explorer/Lindacoin/"
  echo " "
  Lindad getinfo | grep blocks
  echo " "
}

masternode_debug () {
  echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
  echo " " 
  echo " Once sync is complete, run 'Lindad masternode debug'" 
  echo " It should then show: 'masternode started remotely'"
  echo " "
  Lindad masternode debug
}

echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo "!                           !"
echo "! 'Begin setup preferences' !"
echo "!                           !"
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"

PS3='Select your setup preference: '
options=('Staking Wallet (Hot)' 'Standalone Masternode (Hot)' 'Control Masternode (Hot/Cool)' 'Multiple Control Masternodes (Hot/Cool)' 'Cool Wallet' 'Quit')
select opt in "${options[@]}"
do
  case $opt in
    'Staking Wallet (Hot)')
        temp_linda
        install_security
        install_linda
        install_bootstrap
        generate_rpc
        get_ip
        
        linda_conf_core
        linda_conf_listen_yes
        linda_conf_stake
        linda_conf_seeds
        mv ~/Linda.conf ~/.Linda/

        linda_complete
        linda_showaddress
        linda_showblock

        break
        ;;
    'Standalone Masternode (Hot)')
        # Install the masternode and dependencies
        temp_linda
        install_security
        install_linda
        install_bootstrap
        generate_rpc

        linda_conf_core
        linda_conf_listen_yes
        linda_conf_seeds
        cp ~/Linda.conf ~/.Linda

        Lindad
        sleep 20
        get_ip
        masternodegenkey=$(Lindad masternode genkey)
        Lindad stop
        sleep 10

        linda_conf_mn
        mv ~/Linda.conf ~/.Linda/

        linda_complete
        linda_showaddress
        linda_showblock

        break
        ;;
    'Control Masternode (Hot/Cool)')
        # Ask user for masternode genkey
        echo -n "Enter your cool wallet genkey value & press Enter: "
        read -r masternodegenkey

        temp_linda
        install_security
        install_linda
        install_bootstrap
        generate_rpc
        get_ip

        linda_conf_core
        linda_conf_listen_yes
        linda_conf_seeds
        linda_conf_mn
        mv ~/Linda.conf ~/.Linda/

        linda_complete
        linda_showblocks

        break
        ;;
    'Multiple Control Masternodes (Hot/Cool)')
      echo -n "This option is not completed yet"
      echo "This option is not completed yet"
      echo " "
        break
        ipv6_exist=$(/sbin/ifconfig ens3 | awk '/inet6/{print $3}' | grep 2001 | awk 'NR == 1 {print $1}' | wc -l)
        if [[ $ipv6_exists = 0 ]]; then
          echo '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
          echo '!        IPv6 DOES NOT SEEM TO BE CONFIGURED      !'
          echo '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
          echo '!                                                 !'
          echo '! Please enable from https://my.vultr.com/.       !'
          echo '! Click into your server, then Settings > IPv6    !'
          echo '! Then Assign IPv6 Network                        !'
          echo '! Finally completing the steps in the guide       !'
          echo '! Run this script again and select Yes next time  !'
          echo '!                                                 !'
          echo '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
          exit
        elif [[ $ipv6_exists = 1 ]]; then
          echo '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
          echo '!  IPv6 DOES NOT SEEM TO BE CORRECTLY CONFIGURED  !'
          echo '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
          echo '!                                                 !'
          echo '! Please check /etc/network/interfaces            !'
          echo '! Ensure you have multiple entries for            !'
          echo '! iface ens3 inet6 static                         !'
          echo '!                                                 !'
          echo '! Correct this, reboot the server and try again   !'
          echo '!                                                 !'
          echo '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
          exit
        else
          echo '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
          echo '!               IPv6 IS CONFIGURED                !'
          echo '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
        fi

        echo -n "How many total masternodes would you like to have? "
        read -r int

        temp_linda
        generate_rpc

        echo -n "Enter your FIRST cool wallet genkey value & press Enter: "
        read -r masternodegenkey
        ipv6sub=$(/sbin/ifconfig ens3 | awk '/inet6/{print $3}' | grep 2001 | awk 'NR == 1 {print $1}')
        ipaddress='['${ipv6sub::-3}']'
        ipv4lan=$(/sbin/ifconfig ens7 | awk '/inet/{print $2}' | awk 'NR == 1 {print $1}' | cut -c 6-)

        linda_conf_core
        linda_conf_listen_yes
        linda_conf_bind_lan
        linda_conf_bind_ipv6
        linda_conf_seeds
        linda_conf_mn

        install_security
        install_linda
        install_bootstrap
        mv ~/.Linda ~/.Linda01
        sudo mv /usr/local/bin/Lindad /usr/local/bin/Lindad01
        sed '$i<Lindad01>!' >> /etc/rc.local

        counter=2
        until [ $counter -gt $int ]
          do
            cp -R .Linda01 .Linda0${counter}
            temp_linda
            sudo cp /usr/local/bin/Lindad01 /usr/local/bin/Lindad0${counter}
            echo -n "Enter your NEXT cool wallet genkey value & press Enter: "
            read -r masternodegenkey
            ipv6sub=$(/sbin/ifconfig ens3 | awk '/inet6/{print $3}' | grep 2001 | awk 'NR == 2 {print $1}')
              if [[ -z "$ipv6sub" ]]; then
                echo 'Second IPv6 Address not configured'
                break
              fi
            ipaddress='['${ipv6sub::-3}']'
            port="$(($port + 10 ))"

            linda_conf_core
            linda_conf_listen_no
            linda_conf_bind_ipv6
            linda_conf_connect
            linda_conf_mn

            cp ~/Linda.conf ~/.Linda0${counter}/

            sudo cp /usr/local/bin/Lindad01 /usr/local/bin/Lindad0${counter}
            sed '$i<Lindad0${counter}>!' >> /etc/rc.local

            bash_aliases

            ((counter++))
          done
        break
        ;;
    'Cool Wallet Setup')
      echo -n "This option is not completed yet"
        break
      echo -n "How many total masternode addresses would you like to have?"
      return -r int

      temp_linda
      install_security
      install_linda
      install_bootstrap
      generate_rpc

      linda_conf_core
      linda_conf_listen_yes
      linda_conf_seeds

      Lindad
      sleep 10

      counter=1
        until [ $counter -ge $int ]
          do
            addressalias=$(Lindad )
            output=$(Lindad masternode outputs | awk 'NR == "(($counter + 1))" {print $1}')
            index=$(Lindad masternode outputs | awk 'NR == "(($counter + 1))" {print $3}')
            genkey=$(Lindad masternode genkey)
            masternode_conf

            ((counter++))
          done
        break
        ;;
    'Quit')
        break
        ;;
    *) echo invalid option;;
  esac
done
