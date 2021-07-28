#!/bin/bash

File="$3";
LocalDIR="/root/downloads/";
FileDIR="${File%/*}";
FileNAME="${File/#$LocalDIR}";
RemoteDIR="od:/";

if [ -z "$3" ]; then
    exit 0
fi

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

rclone -v move "${FileDIR}" "${RemoteDIR}"--transfers=1 --delete-empty-src-dirs;

curl -k --data chat_id="642609087" --data "text=[DE]-${FileNAME}" "https://api.telegram.org/bot1948337450:AAFXHuG06yhvL0YyWYNL7QAw4xrmExdUhzY/sendMessage";

cat >> /root/.aria2/file.txt <<EOF
$FileDIR
EOF
