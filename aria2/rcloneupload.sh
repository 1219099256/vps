#!/bin/bash

File="$3";
LocalDIR="/root/downloads/";
FileDIR="${File%/*}";
tmpDIR="${File/#$LocalDIR}";
RemoteDIR="/";

if [ -n "`find ${LocalDIR} -name '*.rar'`" ];then
  unrar -p"mrcong.com" x "${File}" "${LocalDIR}pictures/";
  rm -rf "${File}";
  FileDIR="${LocalDIR}pictures/";
  RemoteDIR="${RemoteDIR}pictures/";
fi

rclone move -v "${FileDIR}" od:"${RemoteDIR}" --transfers=3

curl -G https://sre24.com/api/v1/push \
      -d token=1db8e4d7d5d42399cc72f26a7eac5eb8 \
      --data-urlencode msg="下载完成" -d topic="aria2"
