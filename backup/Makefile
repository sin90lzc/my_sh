#自动备份脚本部署的makefile


#导入脚本部署的通过makefile
include ../rule.mk

#定义自动备份脚本部署的目录
INSTALL_PATH:=/etc/cron.daily

#backup_all.sh这个文件不需要部署，这个文件主要是方便手动执行所有备份脚本
INSTALL_FILES:=$(filter-out backup_all.sh,${INSTALL_FILES})
