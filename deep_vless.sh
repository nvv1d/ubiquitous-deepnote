#!/bin/bash

RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
PLAIN='\033[0m'

red() {
    echo -e "\033[31m\033[01m$1\033[0m"
}

green() {
    echo -e "\033[32m\033[01m$1\033[0m"
}

yellow() {
    echo -e "\033[33m\033[01m$1\033[0m"
}

run_v2ray() {
    clear
    echo "#############################################################"
    echo -e "#              ${RED} Deepnote v2ray 一键安装脚本${PLAIN}                 #"
    # ... (other echo statements) ...

    rm -f web config.json
    yellow "开始安装..."
    wget -O temp.zip https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip
    unzip -o temp.zip
    rm -f temp.zip
    mv v2ray web
    
    uuid="779afda6-71f3-4cfe-a123-83cf453f9d4d"

    rm -f config.json
    cat << EOF > config.json
{
    "log": {
        "loglevel": "warning"
    },
    "routing": {
        "domainStrategy": "AsIs",
        "rules": [
            {
                "type": "field",
                "ip": [
                    "geoip:private"
                ],
                "outboundTag": "block"
            }
        ]
    },
    "inbounds": [
        {
            "listen": "0.0.0.0",
            "port": 8080,
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "id": "$uuid"
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "ws",
                "security": "none"
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom",
            "tag": "direct"
        },
        {
            "protocol": "blackhole",
            "tag": "block"
        }
    ]
}
EOF
    nohup ./web run &>/dev/null &
    green "Deepnote v2ray 已安装完成！"
    yellow "请认真阅读项目博客说明文档，配置出站链接！"
    yellow "别忘记给项目点一个免费的Star！"
    echo ""
    yellow "更多项目，请关注：小御坂的破站"
}

while true; do
    run_v2ray
    sleep 14400
done