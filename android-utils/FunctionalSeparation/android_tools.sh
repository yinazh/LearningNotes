#!/bin/sh
DATE=`date "+%Y%m%d_%H%M%S"`
echo ${DATE}
LOCAL_PATH=$(pwd)
echo $LOCAL_PATH
asr blue;

function asr()
{
	FILE=$1
    adb shell screenrecord /sdcard/${FILE}_${DATE}.mp4
}
