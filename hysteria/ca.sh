#!/usr/bin/env bash

password=$(openssl rand -hex 16)
obfs=$(openssl rand -hex 6)

mkdir /ssl
wget  http://www.mvpsliu.tk/od/.v/ssl/destinyl.tk.key -O /ssl/destinyl.tk.key
wget  http://www.mvpsliu.tk/od/.v/ssl/destinyl.tk.crt -O /ssl/destinyl.tk.crt

cat > ./client.json <<EOF
{
    "server": "",
    "alpn": "h3",
    "obfs": "${obfs}",
    "auth_str": "${password}",
    "up_mbps": 50,
    "down_mbps": 50,
    "socks5": {
        "listen": "0.0.0.0:1080"
    },
    "http": {
        "listen": "0.0.0.0:8080"
    }
}
EOF


cat > ./server.json <<EOF
{
    "listen": "",
    "alpn": "h3",
    "obfs": "${obfs}",
    "cert": "/ssl/destinyl.tk.crt",
    "key": "/ssl/destinyl.tk.key" ,
    "auth": {
        "mode": "password",
        "config": {
            "password": "${password}"
        }
    }
}
EOF
