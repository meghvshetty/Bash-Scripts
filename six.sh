#!/bin/sh
YELLOW='\033[1;33m'
RED='\033[0;31m'
SET='\033[0m'
sudo apt update && sudo apt upgrade
sudo apt-get install linux-headers-$(uname -r)

echo "${YELLOW}Clear Files${SET}"
rm -rf /home/user/basehat
rm -rf /home/user/basehat.zip

echo "${YELLOW}Change directory to /home/user${SET}"
cd /home/user

echo "${YELLOW}Downloading source files${SET}"
wget https://github.com/sixfab/Sixfab_RPi_3G-4G-LTE_Base_Shield/raw/master/tutorials/QMI_tutorial/src/quectel-CM.zip
unzip quectel-CM.zip -d /home/user/basehat/ && rm -r quectel-CM.zip

echo "${YELLOW}Checking Kernel${SET}"

case $(uname -r) in
    4.14*) echo $(uname -r) based kernel found
        echo "${YELLOW}Downloading source files${SET}"
        wget https://github.com/sixfab/Sixfab_RPi_3G-4G-LTE_Base_Shield/raw/master/tutorials/QMI_tutorial/src/4.14.zip -O drivers.zip
        unzip drivers.zip -d /home/user/basehat/ && rm -r drivers.zip;;
    4.19*) echo $(uname -r) based kernel found
        echo "${YELLOW}Downloading source files${SET}"
        wget https://github.com/sixfab/Sixfab_RPi_3G-4G-LTE_Base_Shield/raw/master/tutorials/QMI_tutorial/src/4.19.1.zip -O drivers.zip
        unzip drivers.zip -d /home/pi/files/ && rm -r drivers.zip;;
    5.4*) echo $(uname -r) based kernel contains driver;;
    *) echo "Driver for $(uname -r) kernel not found";exit 1;

esac

echo "${YELLOW}Installing udhcpc${SET}"
apt-get install udhcpc

echo "${YELLOW}Copying udhcpc default script${SET}"
mkdir -p /usr/share/udhcpc
cp /home/user/basehat/quectel-CM/default.script /usr/share/udhcpc/
chmod +x /usr/share/udhcpc/default.script

if [ -d /home/user/basehat/drivers ]; then
    echo "${YELLOW}Change directory to /home/pi/files/drivers${SET}";
    cd /home/user/basehat/drivers;
    make && make install;
fi

echo "${YELLOW}Change directory to /home/user/basehat/quectel-CM${SET}"
cd /home/user/basehat/quectel-CM
make

chmod 777  /home/user/basehat/quectel-CM
echo "${YELLOW}After reboot please follow commands mentioned below${SET}"
echo "${YELLOW}go to /home/user/basehat/quectel-CM and run sudo ./quectel-CM -s [YOUR APN]${SET}"

read -p "Press ENTER key to reboot" ENTER
reboot
