# List network outages
# Runs on a file created with this cron job
# */5 * * * * echo -n `date +\%d_\%b\%y_\%H:\%M,` >> ~/speedtest.txt && speedtest -f csv >> ~/speedtest.txt
# Steve Cosgrove, started 15 Sept 2021
# last modified 20 Sept 2021

SPEEDFILE=~/data/speedtest.txt
 PINGFILE=~/data/pingtest.txt

if [ $# -eq 0 ]
    then
    # We want a general report
	DATE=[0-9_]{3}[a-zA-Z0-9_:]{11}

	OUTAGE=$DATE,$DATE

	echo Most recent outages:
	grep -Ea $OUTAGE $SPEEDFILE | awk -F , '{print $1 }' | tail -100
#	grep -Ea $OUTAGE $SPEEDFILE | awk -F , '{print $1 }' | tail -10

	echo Outage history since `awk -F , '{print $1                }' $SPEEDFILE | head -2 | tail -1`:
	echo "Total (including less than 10 minutes): "`grep -E $DATE,$DATE $SPEEDFILE | wc -l`

# Start counting with two an outage spanning two five minute tests
#	CYCLE=$DATE,$DATE,$DATE
#	for (( COUNT=2; COUNT<=19 ; COUNT++ ))

# Count all recorded outages, including those potentially less than five minutes long
	CYCLE=$DATE,$DATE
	for (( COUNT=1; COUNT<=19 ; COUNT++ ))

	do
		CYCLE=$CYCLE,$DATE
		echo -n "Internet outages over "`expr $COUNT \* 5`" minutes: "
	#	echo \*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*
		grep -nE $CYCLE $SPEEDFILE | wc -l

	done
    else
    # look for a specific text string
	grep -a $1 $SPEEDFILE
	grep -aA 2 $1 $PINGFILE
fi
echo
date
# 2057  grep -E $DATE speedtest.txt
# 2058  grep -E $DATE,$DATE,$DATE speedtest.txt
# 2059  grep -E $DATE,$DATE,$DATE speedtest.txt | wc -l
# 2060  grep -E $DATE,$DATE,$DATE,$DATE speedtest.txt | wc -l
# 2061  grep -E $DATE,$DATE,$DATE,$DATE,$DATE speedtest.txt | wc -l
# 2062  history | grep DATE
# 2063  history | grep DATE > speedtest.grep
