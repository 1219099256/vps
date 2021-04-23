### aria2

wget https://raw.githubusercontent.com/1219099256/aria2-backup/master/aria2.sh && chmod +x aria2.sh

### rclone

curl https://rclone.org/install.sh | bash

wget https://raw.githubusercontent.com/1219099256/aria2-backup/master/rclone/rclone.service -P  /etc/systemd/system/

wget -O /root/.aria2/upload.sh https://raw.githubusercontent.com/1219099256/aria2-backup/master/aria2/rcloneupload.sh && chmod +x /root/.aria2/upload.sh

systemctl daemon-reload && systemctl start rclone && systemctl enable rclone

### unrar

wget https://www.rarlab.com/rar/rarlinux-x64-6.0.0.tar.gz && tar -xzvf rarlinux-x64-6.0.0.tar.gz && cd rar && cp rar unrar /usr/local/bin

### colab

wget -O upload.sh https://raw.githubusercontent.com/1219099256/aria2-backup/master/colab/rcloneupload.sh && chmod +x upload.sh

wget -O aria2.tar.bz2 https://github.com/q3aql/aria2-static-builds/releases/download/v1.35.0/aria2-1.35.0-linux-gnu-64bit-build1.tar.bz2
tar -jxvf aria2.tar.bz2
cd aria2 && make install
