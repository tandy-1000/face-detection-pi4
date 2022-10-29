wget https://dietpi.com/downloads/images/DietPi_RPi-ARMv8-Bullseye.7z
7za e DietPi_RPi-ARMv8-Bullseye.7z DietPi_RPi-ARMv8-Bullseye.img
sudo losetup -Pf DietPi_RPi-ARMv8-Bullseye.img
sudo mount -o loop /dev/loop0p2 /media
tar cf root.tar -C /media .
sudo umount /media
sudo losetup -d /dev/loop0
rm -rf DietPi_RPi-ARMv8-Bullseye.img