#!/bin/bash


####################################################################################################
#
#Description:
#	使用tar增量方式备份/etc目录
#
#Sysnopsis:
#
#Options：
#
#History:
#	2013-03-12	初版
#	
#Author：tim	Email：lzcgame@126.com	
#
####################################################################################################

PATH=/sbin:/bin:/usr/sbin:/usr/bin
BACKUP_PATH=/mnt/backup
ETC_PRE=etc_
ETC_SUF=.tar.bz2


#etc备份目录
ETC_PATH=$BACKUP_PATH/etc

#检查etc备份目录是否存在，不存在着创建
[ ! -e $ETC_PATH ] && mkdir -p $ETC_PATH 
[ -d $ETC_PATH ] || echo "etc backup path($ETC_PATH) is not a directory!"



#生成etc备份的文件名
DATE_STR=$(date +%F)
ETC_BACKUP_FILENAME=${ETC_PRE}${DATE_STR}${ETC_SUF}

#etc备份文件如果存在就退出
test -e $ETC_PATH/$ETC_BACKUP_FILENAME && exit 0

#计算已备份etc的文件数,如果etc未备份过，则全量备份etc，否则对比最近的备份文件时间来备份etc
ETC_BACKUP_FILESNUM=$(ls -1 $ETC_PATH | wc -l) 
if [ $ETC_BACKUP_FILESNUM -eq 0 ];then
#全量备份一次
	tar -cjvpPf $ETC_PATH/$ETC_BACKUP_FILENAME /etc
	exit 0
fi

if [ $ETC_BACKUP_FILESNUM -gt 0 ];then
	LASTEST_SEC=0
	ETC_BACKUP_FILES=$(ls -1 $ETC_PATH)

	for var in $ETC_BACKUP_FILES
	do
		TEMP_DATE=$(echo $var | sed s/$ETC_PRE// | sed s/$ETC_SUF//)
		#echo $TEMP_DATE
		TEMP_SEC=$(date -d "$TEMP_DATE" +%s) 
		#echo $TEMP_SEC	
		if [ $TEMP_SEC -gt $LASTEST_SEC ];then
			LASTEST_SEC=$TEMP_SEC
			LASTEST_DATE=$TEMP_DATE
		fi
	done

fi

#增量备份
tar -cjpPf $ETC_PATH/$ETC_BACKUP_FILENAME -N "$LASTEST_DATE" /etc 


