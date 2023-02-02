# Get a single frame from IP camera
# Steve Cosgrove 2 October 2022



# mv snapshot_kahui2.jpg KahuiRd-West_`date +%Y-%m-%d_%H-%M`.jpg

# cosste@home:~$ date +%Y-%m-%d_%H-%M
# 2022-10-02_21-06
# cosste@home:~$

# wget --no-check-certificate --ciphers=DEFAULT:@SECLEVEL=1 https://192.168.80.58/snapshot.cgi?chan=0 --output-document=/var/www/html/birds/test_`date +%Y-%m-%d_%H-%M`.jpg

# Local file specifications
FILEPREFIX=kowhai_
# FILEPREFIX=A_ClassDemo_
FILESUFFIX=.jpg
FILEPATTERN=$FILEPREFIX*	# for deleting small files
FILEMINSIZE=40k			# define 'small'
FILEPATH=/var/www/html/birds/
FILEDATE=`date +%Y-%m-%d_%H-%M`

FILEFULLNAME=$FILEPATH$FILEPREFIX$FILEDATE$FILESUFFIX

FILECURRENTNAME=A-$FILEPREFIX$FILESUFFIX
FILECURRENT=$FILEPATH$FILECURRENTNAME

CAMERA=aircam.rata.co.nz
CAMERA=192.168.80.15 # for when DNS fails

#  ssh details
IDENTITYFILE=/home/cosste/scripts/sshd_rsa_host_key
CAMERALOGIN=birds@$CAMERA
FILESOURCE=$CAMERALOGIN:/var/tmp/ch00.jpeg
LOGSOURCE=$CAMERALOGIN:/var/log/messages

DELETE=-delete # Comment out when testing
# TEST=echo # Comment out when not testting

# scp -i /home/cosste/scripts/sshd_rsa_host_key birds@192.168.80.58:/var/tmp/ch00.jpeg /var/www/html/birds/$FILEPREFIX`date +%Y-%m-%d_%H-%M`.jpg

# Copy the public key to the right place, in case camera has rebooted
# $TEST ssh  -i $IDENTITYFILE $CAMERALOGIN cp sshd_rsa_host_key.pub  /etc/ssh/authorized_keys

# Update the camera time
$TEST ssh  -i $IDENTITYFILE $CAMERALOGIN date `date +%Y.%m.%d-%H:%M:%S`

# Get the most recent photo and a copy of the logs
$TEST scp -i $IDENTITYFILE $FILESOURCE $FILEFULLNAME
$TEST scp -i $IDENTITYFILE $LOGSOURCE  /home/cosste/data/CamLog_$FILEDATE

$TEST cp $FILEFULLNAME $FILECURRENT

$TEST find $FILEPATH -name $FILEPATTERN -size -$FILEMINSIZE $DELETE
