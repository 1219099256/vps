#!/bin/bash

File="$3";
LocalDIR="/root/downloads/";
FileDIR="${File%/*}";
FileNAME="${File/#$LocalDIR}";
RemoteDIR="od:/";

if [ -z "{$File}" ]; then
    exit 0
elif [ "${FileNAME}" = download_repair.php ]; then
    rm "$3"
    exit 0
fi

if [ $FileDIR = /root/downloads ]; then
    if [ -n "`find ${LocalDIR} -name '*.rar'`" ]; then
        unrar -p"mrcong.com" x "${File}" "${LocalDIR}pictures/";
        rm -rf "${File}";
        FileDIR="${LocalDIR}pictures/";
        RemoteDIR="${RemoteDIR}pictures/";
    elif [ -n "`find ${LocalDIR} -name '*.7z'`" ]; then
        7z x "${File}" -p"www.moeblock.com" -o"${LocalDIR}pictures/";
        rm -rf "${File}";
        FileDIR="${LocalDIR}pictures/";
        RemoteDIR="${RemoteDIR}pictures/";
    else
        FileDIR="$3";
    fi
fi

rclone -v move "${FileDIR}" "${RemoteDIR}" --transfers=1 --delete-empty-src-dirs;

curl -k --data chat_id="642609087" --data "text=[FR]-${FileNAME}-已上传至onedrive" "https://api.telegram.org/bot1948337450:AAGqfglgQQul_R4FM_J3pxP1T2QqaXSczVo/sendMessage";

cat >> /root/.aria2/file.txt <<EOF
$FileNAME
EOF
