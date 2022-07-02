# List network outages
# Runs on a file created with this cron job
# */5 * * * * echo -n `date +\%d_\%b\%y_\%H:\%M,` >> ~/speedtest.txt && speedtest -f csv >> ~/speedtest.txt
# Steve Cosgrove, started 15 Sept 2021
# last modified 20 Sept 2021

if [ $# -eq 0 ]
    then
    # We want a general report
	DATE=[0-9_]{3}[a-zA-Z0-9_:]{11}
	DATAFILE=~/data/speedtest.txt
	OUTAGE=$DATE,$DATE

	echo Most recent outages:
	grep -E $OUTAGE $DATAFILE | awk -F , '{print $1 }' | tail -100
#	grep -E $OUTAGE $DATAFILE | awk -F , '{print $1 }' | tail -10

#	echo Outage history since `awk -F , '{print $1                }' ~/speedtest.txt | head -2 | tail -1`:
#	echo "Total (including less than 10 minutes): "`grep -E $DATE,$DATE speedtest.txt | wc -l`

# Start counting with two an outage spanning two five minute tests
#	CYCLE=$DATE,$DATE,$DATE
#	for (( COUNT=2; COUNT<=19 ; COUNT++ ))   `expr $COUNT \* 5`" minutes: "

# Count all recorded outages, including those potentially less than five minutes long
#	CYCLE=$DATE,$DATE
#	for MONTH in September October November
	for MONTH in Sep Oct Nov
	do 
		for (( DAY=1; DAY<=30 ; DAY++ ))

		do
#			CYCLE=$CYCLE,$DATE
			echo -n "Internet outages on "$DAY" "$MONTH": "
		#	echo \*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*
			grep $DAY"_"$MONTH $DATAFILE | grep -nE $OUTAGE | wc -l

		done
	done
    else
    # look for a specific text string
	grep $1 $DATAFILE
fi


# 2057  grep -E $DATE speedtest.txt
# 2058  grep -E $DATE,$DATE,$DATE speedtest.txt
# 2059  grep -E $DATE,$DATE,$DATE speedtest.txt | wc -l
# 2060  grep -E $DATE,$DATE,$DATE,$DATE speedtest.txt | wc -l
# 2061  grep -E $DATE,$DATE,$DATE,$DATE,$DATE speedtest.txt | wc -l
# 2062  history | grep DATE
# 2063  history | grep DATE > speedtest.grep
