CONNECT_IP="10.58.16.117"
#CONNECT_IP="10.58.16.43"
adb connect ${CONNECT_IP};
sleep 1;
adb root;
sleep 1;
adb connect ${CONNECT_IP};
sleep 1;
adb remount;
