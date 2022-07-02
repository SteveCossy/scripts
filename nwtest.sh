# Script to run network tests
# Put into this file by Steve Cosgrove 17 Feb 2022
#
# Detect VF Gateway: ping -4Rt 2 -c 1 vodafone.co.nz

# Get my public IP data: https://api.whatismyip.com/ip.php?key=4bf008e06df888c9b37b7762668b59d5
# https://www.whatismyip.com/login-welcome-page/


SPEEDFILE=">>~/data/speedtest.txt"
 PINGFILE=">>~/data/pingtest.txt"
 PINGDEST="210.246.51.254"
# PINGDEST="203.118.151.254"
# SPEEDFILE=">>~/data/speedtemp.txt"
#  PINGFILE=">>~/data/pingtemp.txt"
#  OUTFILE="~/data/speedtest.txt"

# Remove previous temp files
# rm /tmp/speedtemp.txt
rm /tmp/pingtemp.txt

# Put the date into each file without a new line
eval echo -n `date +\%d_\%b\%y_\%H:\%M,` ${SPEEDFILE}
eval echo -n `date +\%d_\%b\%y_\%H:\%M,` ${PINGFILE}

# Run speedtest and ping then add to each file
# speedtest -f csv          >/tmp/speedtemp.txt
speedtest -f csv >>~/data/speedtest.txt
ping -c 3 $PINGDEST >/tmp/pingtemp.txt

# if [[ -s /tmp/speedtemp.txt ]] ; 
# then
#    eval echo `cat /tmp/speedtemp.txt`   ${SPEEDFILE}
# else
#    echo failed > /tmp/nwtest.txt
# fi

eval grep loss /tmp/pingtemp.txt        ${PINGFILE}
