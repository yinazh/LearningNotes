(1)当ubuntu的时间不显示
先确认是否安装了时间日期指示器：
 sudo apt-get install indicator-datetime
确认已经安装了，重新配置它：
sudo dpkg-reconfigure --frontend noninteractive tzdata
重启Unity：
sudo killall unity-panel-service 
(2)右键打开终端
sudo apt-get install nautilus-open-terminal

