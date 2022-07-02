# Check state of known RAID arrays
# Last modified, Steve, 19 Oct 2021

ls -ld /dev/md*

for VAR in /dev/md[0-9]* ; \
   do echo ___________________________ ; \
      echo -n /dev/md$VAR : ; \
      sudo mdadm --detail $VAR | grep "State :" ; \
      sudo mdadm --detail $VAR | grep "Array Size :" ; \
#      sudo mdadm --detail /dev/md$VAR | grep "/dev/s" ; \
      sudo mdadm --detail $VAR | tail -3
   done

