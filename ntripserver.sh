#!/bin/sh
#

. /etc/default/ntripserver.conf
 
DateStart=`date -u '+%s'`
SLEEPMIN=10     # Wait min sec for next reconnect try
SLEEPMAX=60  # Wait max sec for next reconnect try
while true; 
do
  # while true; do ./ntripserver -M 1 -i /dev/ttys0 -b 9600 -O 2 -a www.euref-ip.net -p 2101 -m Mount2 -n serverID -c serverPass; sleep 60; done
  ntripserver -M 1 -O 3 -a $SERVER -p $PORT -m $MOUNTPOINT -n $USER -c $PASSWORD -i $DEVICE -b $BAUDRATE
  if test $? -eq 0; 
  then 
    DateStart=`date -u '+%s'`; fi
    DateCurrent=`date -u '+%s'`
    SLEEPTIME=`echo $DateStart $DateCurrent | awk '{printf("%d",($2-$1)*0.02)}'`
  if test $SLEEPTIME -lt $SLEEPMIN; then SLEEPTIME=$SLEEPMIN; fi
  if test $SLEEPTIME -gt $SLEEPMAX; then SLEEPTIME=$SLEEPMAX; fi
  # Sleep 2 percent of outage time before next reconnect try
  echo "Retry after " + $SLEEPTIME
  sleep $SLEEPTIME
done
