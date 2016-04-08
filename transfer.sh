#!/bin/bash
if test $# -ne 3
then
    echo "Need 3 Arguments."
    exit 1
fi

source ./config.txt

SOURCE=$1
TARGET=$2
NAME=$3

git svn clone ${SOURCE} --no-metadata ${NAME}
if test $? -eq 0
then
	cd ${NAME}
	git config user.name ${USER_NAME}
	git config user.email ${USER_EMAIL}
	git remote add gitlab ${TARGET}
	git push -u gitlab master
	if test $? -eq 0
	then
		echo "${TARGET} 提交成功!"
		exit 0
	else
		echo "${TARGET} 提交失败！"
		exit 1
	fi
cd -
else
	echo "${SOURCE} 克隆失败！"
	exit 1
fi
