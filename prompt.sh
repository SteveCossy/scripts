# Change bash prompt to show current network
# Steve Cosgrove, started 6 July 2022

# Need to add machine details
# PS1='${debian_chroot:+($debian_chroot)}\u@\h:(Fibre)\w\$ '

a210_246_49_101=fibre
a203_118_151_16=cable

TEMPIP=/tmp/myip.txt

wget --quiet --output-document=$TEMPIP https://api.whatismyip.com/ip.php?key=4bf008e06df888c9b37b7762668b59d5
MYIP=`cat $TEMPIP`
NWIP=a${MYIP//./_}

NWNAME=${!NWIP}

export PS1='${debian_chroot:+($debian_chroot)}\u@\h:($NWNAME)\w\$ '



