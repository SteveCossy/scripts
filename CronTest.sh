# Read how often this script is run by Cron
# Steve Cosgrove, started 30 July 2022

echo $0
COMMAND=`crontab -l | grep $0`
echo ${COMMAND:2:2}

