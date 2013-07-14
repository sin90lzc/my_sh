MKDIR=mkdir

MKDIR_FLAGS=-p

INSTALL=install

INSTALL_FLAGS=

#判断安装目录是否已经存在，如果不存在，则需要先创建目录
ifeq (false,$(shell test -d ${INSTALL_PATH})&& echo "true" || echo "false")
PRE_MK_DIR=${INSTALL_PATH}
endif

#需要部署的文件，排除掉Makefile文件和README文件
INSTALL_FILES:=$(wildcard *)

INSTALL_FILES:=$(filter-out README%,${INSTALL_FILES})

INSTALL_FILES:=$(filter-out Makefile,${INSTALL_FILES})

INSTALL_FILES:=$(filter-out %.mk,${INSTALL_FILES})

#install规则
install:${PRE_MK_DIR} ${INSTALL_FILES}
	${INSTALL} ${INSTALL_FLAGS} ${INSTALL_FILES} ${INSTALL_PATH}

#目录创建规则
${PRE_MK_DIR}:
	${MKDIR} ${MKDIR_FLAGS} $@ 	
