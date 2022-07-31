# List network outages
# Runs on a file created with this cron job
# */5 * * * * echo -n `date +\%d_\%b\%y_\%H:\%M,` >> ~/speedtest.txt && speedtest -f csv >> ~/speedtest.txt
# Steve Cosgrove, started 15 Sept 2021
# last modified 20 Sept 2021

# Finding when outage happened - example
# DATE=[0-9_]{3}[a-zA-Z0-9_:]{11}
# grep -nE $DATE,$DATE,$DATE,$DATE,$DATE ~/data/speedtest.txt

# Need to add machine details
# PS1='${debian_chroot:+($debian_chroot)}\u@\h:(Fibre)\w\$ '


SPEEDFILE=~/data/speedtest.txt
 PINGFILE=~/data/pingtest.txt

# How often is nwtest.sh being run?
ComName=nwtest.sh
ComCron=`crontab -l | grep $ComName`
ComMins=${ComCron:2:2}


if [ $# -eq 0 ]
    then
    # We want a general report
	DATE=[0-9_]{3}[a-zA-Z0-9_:]{11}
	OUTAGE=$DATE,$DATE

	echo
	echo -n "Count of number of outages over $ComMins minutes on "
	~/scripts/prompt.sh
        TOTAL=`grep -E $OUTAGE,$DATE $SPEEDFILE | wc -l`

	for (( COUNT=$TOTAL; COUNT>0 ; COUNT-- ))
	do
            VAR=`grep -aE $OUTAGE,$DATE $SPEEDFILE | tail -$COUNT | head -1`
	    THISDATE=`echo "$VAR " | awk -F , '{ print $1 }' `
	    echo -n "$THISDATE :"
	    RESULT="${VAR//[^:]}"
	    expr ${#RESULT} - 1
        done

    else
    # look for a specific text string
	grep -a $1 $SPEEDFILE
	grep -aA 2 $1 $PINGFILE
fi
echo -n "Report printed: "
date
echo
