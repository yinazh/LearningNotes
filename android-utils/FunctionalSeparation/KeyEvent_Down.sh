#!/bin/sh
##　获取对应的点击事件
## adb -s 10.58.16.117:5555 shell getevent /dev/input/event6
function keyDown() {
  echo "input keydown 20 three times"
  adb shell input keyevent 20;
}

while true
do
    keyDown
done
