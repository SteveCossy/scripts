# Run Speedtest from https://www.speedtest.net/apps/cli
# crontab line: */30 * * * * speedtest -f csv >> ~/speedtest.txt
# Format based on advice at https://www.tutorialspoint.com/awk/awk_basic_examples.htm

DATAFILE=~/data/speedtest.txt

echo
echo Details from speedtest.txt
echo -n "First date: "
awk -F , '{print $1                }'  $DATAFILE | head -2 | tail -1
awk -F , '{print $1 "," $7 "," $8 }'   $DATAFILE | head -1
awk -F , '{print $1 "," $7 "," $8 }'   $DATAFILE | tail -3
# awk -F , '{print $1 "," $7 "," $8 }' $DATAFILE | grep \"0\" | tail -4
awk -F , '{print $11 }'                $DATAFILE | tail -1 | sed 's/\"//g'

DATE=[0-9_]{3}[a-zA-Z0-9_:]{11}
echo -n "Total Internet outages: "`grep -E $DATE,$DATE $DATAFILE | wc -l`
echo " For Details, run ./outages.sh"
