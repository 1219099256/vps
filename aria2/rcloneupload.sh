#!/bin/bash

File="$3";
LocalDIR="/root/downloads/";
RemoteDIR="/root/od/";

if [ -n "`find ${LocalDIR} -name '*.rar'`" ];then
  unrar -p"mrcong.com" x "${File}" "${LocalDIR}pictures/";
  rm -rf "${File}";
  File="${LocalDIR}pictures/";
  RemoteDIR="${RemoteDIR}pictures/";
  else
  curl -G https://sre24.com/api/v1/push \
        -d token=1db8e4d7d5d42399cc72f26a7eac5eb8 \
        --data-urlencode msg="$3"
fi

rclone move -v "${File}" od:/ --transfers=3;
