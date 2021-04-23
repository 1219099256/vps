curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh | bash && wget https://raw.githubusercontent.com/1219099256/filebrowser-backup/master/filebrowser.service -P /lib/systemd/system/ && cd /usr/local/bin/

创建配置数据库：filebrowser -d /etc/filebrowser.db config init

设置监听地址：filebrowser -d /etc/filebrowser.db config set --address 0.0.0.0

设置监听端口：filebrowser -d /etc/filebrowser.db config set --port 8080

设置语言环境：filebrowser -d /etc/filebrowser.db config set --locale zh-cn

设置日志位置：filebrowser -d /etc/filebrowser.db config set --log /var/log/filebrowser.log

添加一个用户：filebrowser -d /etc/filebrowser.db users add root passwd --perm.admin，其中的root和password分别是用户名和密码，根据自己的需求更改。

运行：systemctl start filebrowser.service

停止运行：systemctl stop filebrowser.service

开机启动：systemctl enable filebrowser.service

取消开机启动：systemctl disable filebrowser.service

查看运行状态：systemctl status filebrowser.service
