# Check recent temperatures as previously saved into a file.
# Steve Cosgrove - updated 1 July 2022
#
# Requires sudo apt install lm-sensors
# https://www.cyberciti.biz/faq/install-sensors-lm-sensors-on-ubuntu-debian-linux/
#
# & this line in crontab
# */5 * * * * echo `date` >> ~/data/CPUtemps.txt && sensors -u | grep input >> ~/data/CPUtemps.txt && echo __________________ >> ~/data/CPUtemps.txt

#

echo
tail -8 /home/cosste/data/CPUtemps.txt

 
