#!/bin/bash

# 设置脚本在遇到错误时终止执行
set -e

# 定义变量
SOURCE_DIR="/Users/szcnmj595/Projects/test-ui-link/dist"
TARGET_DIR="/Users/szcnmj595/Projects/h5-shared-document"
ARCHIVE_NAME="dist_$(date +%Y%m%d_%H%M%S).zip"

# 打包目录
cd $SOURCE_DIR
zip -r $ARCHIVE_NAME ./*

# 将打包文件复制到目标 Git 项目目录
cp $ARCHIVE_NAME $TARGET_DIR

# 进入目标 Git 项目目录
cd $TARGET_DIR

# Git 操作
git pull
git add $ARCHIVE_NAME
git commit -m "Added new dist $ARCHIVE_NAME"
git push

# 删除本地打包的文件
rm $ARCHIVE_NAME

echo "***** Operation completed successfully. *****"