#!/bin/sh
DATE=`date "+%Y%m%d_%H%M%S"`
#echo ${DATE}
LOCAL_PATH=$(pwd)
echo $LOCAL_PATH
adb logcat -c ;
echo "start catch log"
echo "**************************************"
if [ $# == 0 ] ;then
  FILENAME="log_${DATE}.log"
  echo $FILENAME
  adb logcat -v time > ${LOCAL_PATH}/$FILENAME
else
  if [ "radio" == $1 ] ;then
    echo "radio logs:"
    FILENAME="log_radio_${DATE}.log"
    echo $FILENAME
    adb logcat -b radio -v time > ${LOCAL_PATH}/$FILENAME
  elif [ "$1" == "main" ] ;then
    echo "main logs:"
    FILENAME="log_main_${DATE}.log"
    echo $FILENAME
    adb logcat -b main -v time > ${LOCAL_PATH}/$FILENAME
  elif [ "$1" == "events" ] ;then
    echo "events logs:"
    FILENAME="log_events_${DATE}.log"
    echo $FILENAME
    adb logcat -b events -v time > ${LOCAL_PATH}/$FILENAME
  else
    echo "grep $1 logs"
    FILENAME="log_${DATE}.log"
    echo $FILENAME
    adb logcat -v time | grep $1 > ${LOCAL_PATH}/$FILENAME
  fi
fi
echo "**************************************"
echo "end catch log"
