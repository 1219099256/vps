#!/usr/bin/env bash

domain=$(openssl rand -hex 8)
password=$(openssl rand -hex 16)
obfs=$(openssl rand -hex 6)
path="/root/hysteria"
# 生成CAkey
openssl genrsa -out hysteria.ca.key 2048
# 生成CA证书
openssl req -new -x509 -days 3650 -key hysteria.ca.key -subj "/C=CN/ST=GD/L=SZ/O=Hysteria, Inc./CN=Hysteria Root CA" -out hysteria.ca.crt

openssl req -newkey rsa:2048 -nodes -keyout hysteria.server.key -subj "/C=CN/ST=GD/L=SZ/O=Hysteria, Inc./CN=*.${domain}.com" -out hysteria.server.csr
# 签发服务端用的证书
openssl x509 -req -extfile <(printf "subjectAltName=DNS:${domain}.com,DNS:www.${domain}.com") -days 3650 -in hysteria.server.csr -CA hysteria.ca.crt -CAkey hysteria.ca.key -CAcreateserial -out hysteria.server.crt

cat > ./client.json <<EOF
{
    "server": "123.123.123.123:5678",
    "alpn": "h3",
    "obfs": "${obfs}",
    "auth_str": "${password}",
    "up_mbps": 30,
    "down_mbps": 30,
    "socks5": {
        "listen": "0.0.0.0:1080"
    },
    "http": {
        "listen": "0.0.0.0:8080"
    },
    "server_name": "www.${domain}.com",
    "ca": "${path}/hysteria.ca.crt"
}
EOF


cat > ./server.json <<EOF
{
    "listen": ":5678",
    "alpn": "h3",
    "obfs": "${obfs}",
    "cert": "${path}/hysteria.server.crt",
    "key": "${path}/hysteria.server.key" ,
    "auth": {
        "mode": "password",
        "config": {
            "password": "${password}"
        }
    }
}
EOF
