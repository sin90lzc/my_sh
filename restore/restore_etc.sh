#!/bin/bash

####################################################################################################
#
#Description:
#	还原/etc
#
#Sysnopsis:
#
#Options：
#
#History:
#	2013-03-20	初版
#	
#Author：tim	Email：lzcgame@126.com	
#
####################################################################################################

PATH=/sbin:/bin:/usr/sbin:/usr/bin
ETC_BACKUP_PATH=/mnt/backup/etc
ETC_PRE=etc_
ETC_SUF=.tar.bz2

#判断备份目录是否已经存在，不存在直接退出
test ! -e $ETC_BACKUP_PATH && echo 'No such file or directory!' && exit 1

#保存所有备份文件列表
BACKUP_FILES=$(ls -1 ${ETC_BACKUP_PATH}/${ETC_PRE}*${ETC_SUF})

#备份文件的数量
BACKUP_FILES_NUM=$(echo ${BACKUP} | wc -l)

#如果没有备份文件，直接退出
test $BACKUP_FILES_NUM -le 0 && echo 'No file to restore!' && exit 1

#for((i=0;i<${BACKUP_FILES_NUM};i++))
#do
#	
#done

#把文件列表放入到数组arr中 
declare -a arr
num=0
for var in $BACKUP_FILES
do
	arr[${num}]=$var
	num=$(($num+1))
done

#把文件按时间排序
if [ $num -gt 1 ];then
	for((i=0;i<${BACKUP_FILES_NUM};i++))
	do
		for((j=${i};j<${BACKUP_FILES_NUM}-1;j++))
		do
			A_DATE=$(echo ${arr[${j}]} | sed s/.*$ETC_PRE// | sed s/$ETC_SUF//)
			A_SEC=$(date -d $A_DATE +%s)			
			B_DATE=$(echo ${arr[$((${j}+1))]} | sed s/.*$ETC_PRE// | sed s/$ETC_SUF// )
			B_SEC=$(date -d $B_DATE +%s)		
			if [ $A_SEC -gt $B_SEC ];then
				TEMP=${arr[${j}]}
				arr[${j}]=arr[$(${j}+1)]
				arr[$(${j}+1)]=$TEMP
			fi
		done
	done
fi
unset num

#按顺序还原备份文件
for var in $arr
do
	tar -xjpPf $var	
done
