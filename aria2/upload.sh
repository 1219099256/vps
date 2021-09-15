#!/bin/bash

File="$3";
LocalDIR="/root/downloads/";
FileAbsoluteDIR="${File%/*}/";
FileNAME="${File/#$LocalDIR}";
RemoteDIR="od:/";
FileDIR="${FileNAME%%/*}/";

if [ $2 -eq 0 ]; then
    exit 0
elif [ "${FileNAME}" = download_repair.php ]; then
    rm "$3"
    exit 0
fi

if [ $2 -eq 1 ]; then
    #单文件
    if [ -n "`find ${LocalDIR} -name '*.rar'`" ]; then
        unrar -p"mrcong.com" x "${File}" "$LocalDIR${FileNAME%.*}/";
        rm -rf "${File}";
        FileAbsoluteDIR="$LocalDIR${FileNAME%.*}/";
        RemoteDIR="${RemoteDIR}pictures/";
    else
        FileAbsoluteDIR="$3";
    fi
else
    #文件夹
    RemoteDIR="${RemoteDIR}${FileDIR}";
fi

rclone -v move "${FileAbsoluteDIR}" "${RemoteDIR}" --transfers=8 --delete-empty-src-dirs;

curl -k --data chat_id="642609087" --data "text=[]-${FileNAME}-已上传至OneDrive" "https://api.telegram.org/bot/sendMessage";

cat >> /root/.aria2/file.txt <<EOF
$FileNAME
EOF
