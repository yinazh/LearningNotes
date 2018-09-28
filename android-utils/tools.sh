#!/bin/sh

function keyDown() {
  echo "input keydown 20 three times"
  adb shell input keyevent 20;
}

#for sign apk
function xg_sign(){
  LOCAL_PATH=$(pwd)
  UNSIGN_FILENAME=$1
  NEW_SIGN_TOOLS_PATH=/media/yinazh/Backup/tools/signapk
  OLD_SIGN_TOOLS_PATH=/media/yinazh/Backup/tools/signapk_old
  local SIGN_TOOLS_PATH
  if [ -z "$1" ] ;then
      echo "unsign application is null..."
  else
    if [ "$2" ] ;then
        echo "old sign ..."
        SIGN_TOOLS_PATH=${OLD_SIGN_TOOLS_PATH}
    else
        echo "sign ..."
        SIGN_TOOLS_PATH=${NEW_SIGN_TOOLS_PATH}
    fi
    java -jar ${SIGN_TOOLS_PATH}/signapk.jar -w ${SIGN_TOOLS_PATH}/platform.x509.pem ${SIGN_TOOLS_PATH}/platform.pk8 ${UNSIGN_FILENAME} "app_sign.apk"
    mv ${LOCAL_PATH}/app_sign.apk ${UNSIGN_FILENAME}
    echo "sign completed"
  fi
}

function alogRT(){
   adb logcat -s AndroidRuntime;
}

function xlogcat(){
  DATE=`date "+%Y%m%d_%H%M%S"`
  #echo ${DATE}
  LOCAL_PATH=$(pwd)
  echo $LOCAL_PATH
  adb logcat -c ;
  echo "start catch log"
  echo "**************************************"
  if [ -z "$1" ] ;then
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
}
