#!/bin/bash

File="$3";
LocalDIR="/content/downloads/";
RemoteDIR="/content/drives/od/";

if [ -e $LocalDIR*.rar ];then
  unrar -p"mrcong.com" x ${File} ${LocalDIR}pictures/;
  rm -rf ${File};
  File="${LocalDIR}pictures/";
  RemoteDIR="${RemoteDIR}pictures/";
fi

rclone move "${File}" "${RemoteDIR}" --config /usr/local/sessionSettings/rclone.conf --fast-list --user-agent "Mozilla" --transfers 20 --checkers 20 --drive-server-side-across-configs -c --buffer-size 256M --drive-chunk-size 256M --drive-upload-cutoff 256M --drive-acknowledge-abuse --drive-keep-revision-forever --tpslimit 95 --tpslimit-burst 40 --stats-one-line --bwlimit 10M --stats=5s -v

cat >> /content/upload.txt << EOF
$3
EOF
