#!/bin/bash

File="$3";
LocalDIR="/root/downloads/";
FileDIR="${File%/*}";
FileNAME="${File/#$LocalDIR}";
RemoteDIR="/root/od/";

if [ $FileDIR = /root/downloads ]; then
    if [ -n "`find ${LocalDIR} -name '*.rar'`" ]; then
        unrar -p"mrcong.com" x "${File}" "${LocalDIR}pictures/";
        rm -rf "${File}";
        FileDIR="${LocalDIR}pictures/";
        RemoteDIR="${RemoteDIR}pictures/";
    else
        FileDIR="$3";
    fi
fi

rclone move "${FileDIR}" "${RemoteDIR}";

curl -G https://sre24.com/api/v1/push \
      -d token=1db8e4d7d5d42399cc72f26a7eac5eb8 \
      --data-urlencode msg="[DE]-${FileNAME}" -d topic="aria2";

cat >> /root/.aria2/file.txt <<EOF
$FileDIR
EOF
