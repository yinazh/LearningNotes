#!/bin/bash

echo "*********************************************"
#使用变量
author="yinazh"
age=30
#可以直接进行赋值来修改变量的值
echo "$author start at $age"
echo "*********************************************"

#显示时间与登录者
echo The time is:
date
echo Login:
who
#同行显示 -n不输出行尾的换行符，-e 允许对下面列出的加反斜线转义的字符进行解释
echo -n -e 'The time is: '
date
echo -n -e 'Login: '
who
echo "*********************************************"

#使用方括号执行数字运算
var1=10
var2=20
var3=50
var4=$[$var1 * $var2 + $var3]
echo result=$var4
echo "*********************************************"

#通过反引号获得当前日期并生成唯一文件名
today=`date +%y%m%d`
ls ~/ > log_$today.log
echo "*********************************************"
