#!/bin/bash

####################################################################################################
#
#Description:
#	使用dump备份/home备份
#
#Sysnopsis:
#
#Options：
#
#History:
#	2013-03-12	初版
#	2013-03-20	添加使用bz2压缩,解决第一次备份时即全量备份同时备份了1的问题
#	
#Author：tim	Email：lzcgame@126.com	
#
####################################################################################################


#备份路径
BACKUP_PATH=/mnt/backup

#home备份路径
HOME_PATH=$BACKUP_PATH/home

#检查home备份目录是否存在，不存在着创建
[ ! -e $HOME_PATH ] && mkdir -p $HOME_PATH
[ -d $HOME_PATH ] || echo "home backup path($HOME_PATH) is not a directory!"

#备份后缀
HOME_BACKUP_SUFFIX=home.dump

#已备份的文件列表
HOME_BACKUP_FILES=$(ls -1 $HOME_PATH)

#如果没有备份过，则全量备份
if [ -z "$HOME_BACKUP_FILES" ];then
	dump -0u -j2 -f ${HOME_PATH}/0${HOME_BACKUP_SUFFIX} /home
	exit 0
fi

#计算最大备份编号
MAX_BACKUP_NUM=0

for var in $HOME_BACKUP_FILES
do
	TEMP_NUM=${var%${HOME_BACKUP_SUFFIX}}	
	echo $TEMP_NUM
	if [ $TEMP_NUM -gt $MAX_BACKUP_NUM ];then
		MAX_BACKUP_NUM=$TEMP_NUM
	fi
done

#本次备份编号
CUR_BACKUP_NUM=$(($MAX_BACKUP_NUM+1))

#本次备份文件名
HOME_BACKUP_FILENAME=${CUR_BACKUP_NUM}${HOME_BACKUP_SUFFIX}

#增量备份
dump -${CUR_BACKUP_NUM}u -j2 -f ${HOME_PATH}/${HOME_BACKUP_FILENAME} /home

