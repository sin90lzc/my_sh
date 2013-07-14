#脚本部署的makefile


#需要部署脚本的目录作为规则
SUB_DIRS=backup execute pubscript

.PHONY:${SUB_DIRS}

install:${SUB_DIRS}

#分别进入需要部署的目录执行makefile
${SUB_DIRS}:
	@cd $@;${MAKE} ${MAKECMDGOALS}
