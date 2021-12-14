# README

#阿里云盘挂载
```
rclone mount aliyun:share /volume1/DSM/emby/share1  --allow-non-empty --allow-other --dir-cache-time 12h  >/dev/null 2>&1 &

rclone mount aliyun:share /root/share  --allow-non-empty --allow-other --dir-cache-time 12h  >/dev/null 2>&1 &

```

Good luck, guys!

# SSR节点列表生成器
> 适配ios版shadowrocket，PC或Mac版小飞机,

## 说明
- `/dist `位节点生成的目录,这个目录是给[netlify](https://app.netlify.com/)应用的
- `node.txt`为SS或SSR节点列表文件(支持类bash脚本注释，举个栗子: `# 注释`)
- `app.js`为项目的核心逻辑

如果你有什么问题，Please open an issues


## 更新说明
- 支持SS或者SSR

## 问题
- 据反映安卓或者Windows客户端可能无法订阅成功，请为添加的每一个节点设置相同的**分组**


## VPS一键添加/删除Swap虚拟内存

``wget https://www.moerats.com/usr/shell/swap.sh && bash swap.sh``

## H5ai
```
apt-get install git -y

git clone https://github.com/wulabing/h5ai_onekey_install-lnp-.git h5ai

cd h5ai

Debian 8运行命令

bash h5ai.sh
 
Debian 9运行命令

sed -i '53,54d' h5ai.sh && bash h5ai.sh
```

- H5ai修改版
```
mkdir /home/wwwroot/Cloud

cd /home/wwwroot

wget https://github.com/Pearlulu/h5ai_dplayer/archive/master.zip && unzip master.zip

cp -r  /home/wwwroot/h5ai_dplayer-master/* /home/wwwroot

rm -rf master.zip h5ai_dplayer-master hls_aria2.sh subtovtt.sh hls_general.sh README.md
```
## DirectoryLister
```
wget https://www.moerats.com/usr/shell/DirectoryLister_ssl.sh && bash DirectoryLister_ssl.sh

wget https://github.com/yenkj/DirectoryLister/archive/master.zip && unzip master.zip

cp -r  /home/wwwroot/domain.com/DirectoryLister-master/* /home/wwwroot/domain.com

rm -rf master.zip DirectoryLister-master
```
## aliyundrive-webdav
```
docker run \
-d \
--name=aliyundrive-webdav \
--restart=always \
-p 8080:8080 \
-v /volume1/DSM/emby/aliyun/:/etc/aliyundrive-webdav/ \
-e REFRESH_TOKEN='2f7766281d7b43629db5c560fe22a14e' \
-e WEBDAV_AUTH_USER=yankj \
-e WEBDAV_AUTH_PASSWORD=ykj123456 \
messense/aliyundrive-webdav
```
## rclone
```
wget https://www.moerats.com/usr/shell/rclone_debian.sh && bash rclone_debian.sh

rclone config
```
- 挂载
```
cd /d d:\rclone
rclone authorize "onedrive"
```
```
mkdir /home/wwwroot/Cloud

rclone mount banana:share /home/wwwroot/Cloud  --allow-non-empty --allow-other --vfs-cache-mode writes --dir-cache-time 25h --buffer-size 0M --vfs-read-chunk-size 128M --vfs-read-chunk-size-limit 1G

command="mount banana:share /home/wwwroot/Cloud  --allow-non-empty --allow-other --vfs-cache-mode writes --dir-cache-time 25h --buffer-size 0M --vfs-read-chunk-size 128M --vfs-read-chunk-size-limit 1G"
```
- 以下是一整条命令，一起复制到SSH客户端运行
```
cat > /etc/systemd/system/rclone.service <<EOF
[Unit]
Description=Rclone
After=network-online.target

[Service]
Type=simple
ExecStart=$(command -v rclone) ${command}
Restart=on-abort
User=root

[Install]
WantedBy=default.target
EOF
``` 
- 开始启动：`systemctl start rclone`
- 设置开机自启：`systemctl enable rclone`

- 卸载：`fusermount -qzu /home/wwwroot/Cloud`
- 重启：`systemctl restart rclone`
- 停止：`systemctl stop rclone`
- 状态：`systemctl status rclone` 
## openwrt
`fusermount -qzu /mnt/sda3/docker/emby/share`
```
rclone mount banana:share /mnt/sda3/docker/emby/share \
--allow-non-empty \
--allow-other \
--vfs-cache-mode writes \
--dir-cache-time 25h \
--buffer-size 512M \
--vfs-read-chunk-size 128M \
--vfs-read-chunk-size-limit 1G &
```

## Emby恢复
``` 
systemctl stop emby-server
rm -rf /var/lib/emby
rclone copy banana:share/emby.zip /var/lib -v
unzip emby.zip
chown -R emby:emby /var/lib/emby
reboot
```
## Plex恢复
```
systemctl stop plexmediaserver.service
rm -rf /var/lib/plexmediaserver
rclone copy banana:share/plexmediaserver.zip /var/lib -v
unzip plexmediaserver.zip
chown -R plex:plex /var/lib/plexmediaserver
reboot
```
## openwrt的Emby
```
docker run \
-d \
--net=host \
--name=emby2 \
-e PUID=1000 \
-e PGID=1000 \
-e TZ=Asia/Shanghai  \
-p 1900:1900 \
-p 7359:7359 \
-p 7359:7359/udp \
-p 8096:8096 \
-p 8920:8920 \
-v /mnt/sda3/docker/emby/config:/config \
-v /mnt/sda3/docker/emby/share:/mnt/share \
-v /dev/shm/cache:/dev/shm/cache \
--restart=always \
linuxserver/emby:arm64v8-latest
docker ps -a
docker container update -m 800M --memory-swap=2048M 26caa2084196
```
## 进入docker
```
docker ps -a
docker exec -it abe31ff51ddd /bin/bash
```
## DSM的Emby
```
hypervisor.cpuid.v0
```
```
vim /etc/crontab
@reboot root  rclone mount banana:share /volume1/DSM/emby/share  --allow-non-empty --allow-other --dir-cache-time 12h  >/dev/null 2>&1 &
@reboot root  rclone mount banana:share /volume1/DSM/emby/share  --allow-non-empty --allow-other --vfs-cache-mode writes --dir-cache-time 25h --buffer-size 0M --vfs-read-chunk-size 128M --vfs-read-chunk-size-limit 1G
```
```
docker exec -it a637ab2b96fe /bin/sh
```
```
docker run \
-d \
--net=host \
--name=emby \
-m 2G \
--device /dev/dri:/dev/dri \
-e UID=0 \
-e GID=0 \
-e GIDLIST=0 \
-e TZ=Asia/Shanghai  \
-p 1900:1900 \
-p 7359:7359 \
-p 7359:7359/udp \
-p 8096:8096 \
-p 8920:8920 \
-v /volume1/docker/emby/config:/config \
-v /volume1/docker/emby/system/dashboard-ui:/system/dashboard-ui \
-v /volume1/docker/emby/system/traystrings:/system/traystrings \
-v /volume1/docker/emby/system/Emby.Web.dll:/system/Emby.Web.dll \
-v /volume1/docker/emby/system/MediaBrowser.Model.dll:/system/MediaBrowser.Model.dll \
-v /volume1/docker/emby/system/Emby.Server.Implementations.dll:/system/Emby.Server.Implementations.dll \
-v /volume1/DSM/emby/share:/mnt/share \
-v /dev/shm:/dev/shm \
--restart=always \
emby/embyserver:latest
```
## dxz的Emby
```
docker run \
-d \
--net=host \
--name=emby00 \
-m 2G \
--device /dev/dri:/dev/dri \
-e UID=0 \
-e GID=0 \
-e GIDLIST=0 \
-e TZ=Asia/Shanghai  \
-p 1900:1900 \
-p 7359:7359 \
-p 7359:7359/udp \
-p 8096:8096 \
-p 8920:8920 \
-v /volume1/docker/emby00/emby/config:/config \
-v /volume1/DSM/emby/00:/00 \
-v /dev/shm:/dev/shm \
emby/embyserver:latest
```

## Aria2和ariang
- Aria2
```
wget -N git.io/aria2.sh && chmod +x aria2.sh && bash aria2.sh
```
- aria2文件夹 

`/root/.aria2c`   
- 配置文件
```
https://raw.githubusercontent.com/yenkj/ssr_subscrible_tool/master/aria2.conf
https://raw.githubusercontent.com/yenkj/ssr_subscrible_tool/master/upload.sh
```
- ariang
```
apt-get install unzip -y
mkdir /home/wwwroot/ariaNg  
cd /home/wwwroot/ariaNg
wget https://www.moerats.com/usr/down/aria-ng-0.2.0.zip && unzip aria-ng-0.2.0.zip  
```
- 创建下载目录 `mkdir -p /root/Download`  
- 给予权限 `chmod +x /root/.aria2c/upload.sh`
- 重启aria2 `/etc/init.d/aria2 restart`


## nginx
- 重载nginx `systemctl reload nginx`      
- nginx文件夹 `/etc/nginx/conf/conf.d`         
## openvz bbr
```
wget https://github.com/tcp-nanqinlang/lkl-rinetd/releases/download/1.1.0-nocheckvirt/tcp_nanqinlang-rinetd-debianorubuntu-nocheckvirt-multiNIC.sh
bash tcp_nanqinlang-rinetd-debianorubuntu-nocheckvirt-multiNIC.sh
```
## openvz v2ray
`wget -N --no-check-certificate -q -O install.sh "https://raw.githubusercontent.com/yenkj/V2Ray_ws-tls_bash_onekey/master/install.sh" && chmod +x install.sh && bash install.sh`

- 证书位置 `/root/.acme.sh/`

## SSR订阅地址
https://quirky-bardeen-bde2df.netlify.com/
## GD百宝箱
```
apt-get install curl git unzip zip python3-distutils python3 python3-pip

apt-get install screen git && curl https://rclone.org/install.sh | sudo bash

python3 gen_sa_accounts.py --quick-setup -1

cp -r /root/AutoRclone/accounts/* /root/gd-utils/sa

bash -c "$(curl -fsSL https://raw.githubusercontent.com/vitaminx/gd-utils/master/gdutilsinstall.sh)"
```

请输入机器人token并回车
    
    Your Bot Token =>:1352493505:AAFzll21Y6WTheXV6eMTfe1B-roQKWOwbjc

请输入你的域名(在cloudflare上解析到你机器人所在VPS的域名，格式：bot.abc.com)并回车
   
   Your Domain Name =>:tg.199301.xyz

请输入使用机器人的telegram账号ID(获取ID机器人@userinfobot)并回车
    
    Your Telegram ID =>:445209991

请输入转存默认目的地团队盘ID(不指定转存目的地默认改地址，脚本强制要求输入团队盘ID)并回车
   
   Your Google Team Drive ID =>:0AO4-CX_XxBu3Uk9PVA
