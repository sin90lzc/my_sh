#!/bin/bash

####################################################################################################
#
#Description:
#	每天全量备份/root目录
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

BACKUP_PATH=/mnt/backup/root

[ ! -e $BACKUP_PATH ] && mkdir -p $BACKUP_PATH

[ ! -d $BACKUP_PATH ] && echo "$BACKUP_PATH is not a directory" && exit 1

BACKUP_DATE=$(date +%F)

BACKUP_FILENAME_PREFIX=root_

[ -e $BACKUP_PATH/${BACKUP_FILENAME_PREFIX}${BACKUP_DATE} ] && exit 0

tar -cjpPf $BACKUP_PATH/${BACKUP_FILENAME_PREFIX}${BACKUP_DATE} --exclude=/root/download/* /root

