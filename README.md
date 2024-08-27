# README
## 安装SSL证书
```
apt update -y
apt install -y curl
apt install -y socat
curl https://get.acme.sh | sh
~/.acme.sh/acme.sh --register-account -m xxx@xxx.xxx
~/.acme.sh/acme.sh --issue -d xxxx.xxxx.xxx --standalone
更换你的解析域名
~/.acme.sh/acme.sh --installcert -d xxxx.xxxx.xxx --key-file /root/private.key --fullchain-file /root/cert.crt 
```
## 安装X-ui面板
```
bash <(curl -Ls https://raw.githubusercontent.com/vaxilu/x-ui/master/install.sh)
```
## aliyundrive-webdav
```
docker run \
-d \
--name=aliyundrive-webdav \
--restart=always \
-p 8080:8080 \
-v /volume1/DSM/emby/aliyun/:/etc/aliyundrive-webdav/ \
-e REFRESH_TOKEN=eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJjZGM4ZjUxNGQxZWM0N2ZlOTk3MzA4NjkyY2M3YWJkMSIsImF1ZCI6IjczZTYxMTgzMWE3YzRkODdhYzQ5Yzg0ODFiZjlmMmM0IiwiZXhwIjoxNzEyNjYyMjMzLCJpYXQiOjE3MDQ4ODYyMzMsImp0aSI6IjY2MWJjNWU0ZTE2ZjQ5ZDFhOWQ1ZGUzNmIwM2E4ODQ5In0.OcDdmRvvTAPqSXyv4p4g5ZpdB1QbR9xDl36GjLjdxVzPmImCgXzcHidqg71YshNqHdowKVAcDusbCBGXfzIQVw \
messense/aliyundrive-webdav
```
- 阿里云盘挂载
```
[aliyun]
type = webdav
url = http://0.0.0.0:8080
vendor = other
rclone mount aliyun:share /volume1/DSM/emby/share1 --cache-dir /tmp --allow-other --vfs-cache-mode writes --allow-non-empty
```
## 进入docker
```
docker ps -a
docker exec -it abe31ff51ddd /bin/bash
docker exec -it emby /bin/sh
```
## pixman
```
docker run -d --name=4gtv -p 6000:5000 -v /volume1/docker/m3u:/app/app/data/m3u --restart=always pixman/pixman
```
## DSM的Emby
```
hypervisor.cpuid.v0
```
```
sudo ln -s /bin/fusermount /bin/fusermount3
vim /etc/crontab
@reboot root rclone mount banana:share /volume1/DSM/emby/share --copy-links --allow-other --allow-non-empty --umask 000 --daemon
@reboot root rclone mount pikpak:share /volume1/DSM/emby/sharep --copy-links --allow-other --allow-non-empty --umask 000 --daemon
@reboot root  rclone mount banana:share /volume1/DSM/emby/share  --allow-non-empty --allow-other --vfs-cache-mode writes --dir-cache-time 25h --buffer-size 0M --vfs-read-chunk-size 128M --vfs-read-chunk-size-limit 1G
@reboot root sleep 60;docker start emby
```
```
docker run \
-d \
--network=host \
--name=emby \
-m 2G \
--device /dev/dri:/dev/dri \
-e UID=0 \
-e GID=0 \
-e GIDLIST=0 \
-e TZ=Asia/Shanghai \
-p 1900:1900 \
-p 7359:7359/udp \
-p 8096:8096 \
-p 8920:8920 \
-v /volume1/docker/emby/config:/config \
-v /volume1/docker/emby/system/traystrings:/system/traystrings \
-v /volume1/DSM/emby/share:/mnt/share \
-v /volume1/DSM/emby/sharep:/mnt/sharep \
-v /volume1/docker/emby/system/Emby.Web.dll:/system/Emby.Web.dll \
-v /volume1/docker/emby/system/MediaBrowser.Model.dll:/system/MediaBrowser.Model.dll \
-v /volume1/docker/emby/system/dashboard-ui/modules/emby-apiclient/connectionmanager.js:/system/dashboard-ui/modules/emby-apiclient/connectionmanager.js \
-v /volume1/docker/emby/system/dashboard-ui/embypremiere/embypremiere.js:/system/dashboard-ui/embypremiere/embypremiere.js \
-v /volume1/docker/emby/system/Emby.Server.Implementations.dll:/system/Emby.Server.Implementations.dll \
-v /dev/shm:/dev/shm \
--restart=always \
emby/embyserver:latest
```
- emby 破解
```
docker exec emby /bin/sh -c 'wget -O - https://raw.githubusercontent.com/yenkj/vps/master/docker_crack_arm.sh | sh'
docker restart emby
```
```
docker exec emby /bin/sh -c 'wget -O - https://act.jiawei.xin:10086/tmp/emby/4.8.3.0/docker_crack_4.8.3.0.sh | sh'
docker restart emby
```
- emby 美化
```
docker exec emby /bin/sh -c 'cd /system/dashboard-ui && wget -O - https://raw.githubusercontent.com/yenkj/emby-crx/master/script.sh | sh'
```
main.js第七行
```
this.itemQuery = { ImageTypes: "Backdrop", EnableImageTypes: "Logo,Backdrop", IncludeItemTypes: "Movie,Series", SortBy: "ProductionYear, PremiereDate, SortName", Recursive: true, ImageTypeLimit: 1, Limit: 10, Fields: "ProductionYear", SortOrder: "Descending", EnableUserData: false, EnableTotalRecordCount: false };
```
默认排序为ProductionYear, PremiereDate, SortName，
改成DateCreated，让最新入库的媒体放在最前面，非常醒目。
也可以修改轮播图数量上限，默认10张。
因为我的媒体库名称写在了封面上，所以不需要媒体库标题显示，修改style.css第37行：
```
display: flex; /* 如果不需要媒体库标题显示, 请将flex改为none */
```
## nginx
- 重载nginx `systemctl reload nginx`      
- nginx文件夹 `/etc/nginx/conf.d`
- 证书位置 `/root/.acme.sh/`
- 反代实现第三方播放器
```
docker run --name=nginx-m -p 8099:80 --restart=always -v /volume1/docker/emby/conf.d:/etc/nginx/conf.d -d nginx
```
```
nohup python3 ExternalUrl.py  > ExternalUrl.log 2>&1 &
```
```
server {
    listen 80;
    server_name us.199301.xyz;   
    location / {
    proxy_redirect off;  
        proxy_set_header Host $host;  
        proxy_set_header X-Real-IP $remote_addr;  
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;  
		proxy_read_timeout 240s; 
        proxy_pass http://192.168.2.189:8096/;  
    if ( $request_uri ~* /Users/(.*)/Items/\d\d\d+.\?X-Emby-Client )
    {
	proxy_pass http://192.168.2.189:12345;
    }
    if ( $request_uri ~* redirect2player )
    {
	return 301 $arg_infuseurl;
    }
     if ($args ~ (^|.*)&MaxStreamingBitrate=\d*(.*)) {
            set $args $1&MaxStreamingBitrate=1600000000$2;
        }
      }
}
```
```
server {
    listen 80;
    server_name localhost;   
    location / {
    proxy_redirect off;  
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header X-Forwarded-Protocol $scheme;
        proxy_set_header X-Forwarded-Host $http_host;
        proxy_pass http://192.168.2.189:8096/;  
     if ($args ~ (^|.*)&MaxStreamingBitrate=\d*(.*)) {
            set $args $1&MaxStreamingBitrate=1600000000$2;
        }
    }
}
```
## filebrowser
```
docker run -d \
-v /home/wwwroot/Cloud:/srv/share0 \
-v /home/wwwroot/p:/srv/p \
-v /home/wwwroot/ali:/srv/ali \
-v /home/qb/downloads:/srv/qb \
-v /home/wwwroot/filebrowser/database/filebrowser.db:/database/filebrowser.db \
-v /home/wwwroot/filebrowser/config/settings.json:/config/settings.json \
-e PUID=0 \
-e PGID=0 \
-p 7788:80 \
--name=share \
--privileged=true \
--restart always \
filebrowser/filebrowser:latest
```
## pikpak-webdav
```
docker run --name pikpak-webdav --restart=unless-stopped -p 9867:9867 -e PIKPAK_USER='ykj363963169@gmail.com' -e PIKPAK_PASSWORD='*******' ykxvk8yl5l/pikpak-webdav:latest
docker run -d --name=pikpak-webdav --restart=unless-stopped --network=host -v /etc/localtime:/etc/localtime -e TZ="Asia/Shanghai" -e JAVA_OPTS="-Xmx512m" -e SERVER_PORT="9867" -e PIKPAK_USERNAME="ykj363963169@gmail.com" -e PIKPAK_PASSWORD="*******" -e PIKPAK_PROXY_HOST="" -e PIKPAK_PROXY_PORT="" -e PIKPAK_PROXY_PROXY-TYPE="HTTP"  vgearen/pikpak-webdav
```
## aria2-pro
```
docker run \
--net=host \
--restart=always \
--name=aria2-pro \
-e TZ=Asia/Shanghai \
-e UID=0 \
-e GID=0 \
-e RPC_SECRET=ykj123456 \
-v /volume1/DSM/aria2/config:/config \
-v /volume1/DSM/aria2/downloads:/downloads \
p3terx/aria2-pro:latest
```
## homeassistant
```
docker run -d --name hassio_supervisor --privileged \
--restart always \
-v /var/run/docker.sock:/var/run/docker.sock \
-v /var/run/dbus:/var/run/dbus \
-v /volume1/docker/hassio:/data \
-e SUPERVISOR_SHARE=/volume1/docker/hassio \
-e SUPERVISOR_NAME=hassio_supervisor \
-e HOMEASSISTANT_REPOSITORY=homeassistant/qemux86-64-homeassistant \
ghcr.io/home-assistant/amd64-hassio-supervisor
```
## rclone
```
wget https://www.moerats.com/usr/shell/rclone_debian.sh && bash rclone_debian.sh
sudo -v ; curl https://rclone.org/install.sh | sudo bash
rclone config
```
- 挂载
```
cd /d d:\rclone
rclone authorize "onedrive"
rclone authorize "drive" "eyJzY29wZSI6ImRyaXZlIn0"
```
```
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
- windows挂载
```
https://github.com/kapitainsky/RcloneBrowser/releases
--cache-dir C:\rclone\Cache --vfs-cache-mode writes --buffer-size 64M --low-level-retries 200 --dir-cache-time 12h --vfs-read-chunk-size 128M --vfs-read-chunk-size-limit 1G
```
- 开始启动：`systemctl start rclone`
- 设置开机自启：`systemctl enable rclone`
- 卸载：`fusermount -qzu /home/wwwroot/Cloud`
- 重启：`systemctl restart rclone`
- 停止：`systemctl stop rclone`
- 状态：`systemctl status rclone`
- 位置：`/root/.config/rclone/rclone.conf`
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
## ARM的Emby
```
docker run \
-d \
--network=bridge \
--name=emby \
-e UID=0 \
-e GID=0 \
-e GIDLIST=0 \
-e TZ=Asia/Shanghai \
-p 1900:1900 \
-p 7359:7359/udp \
-p 8099:8096 \
-p 8920:8920 \
-v /volume1/docker/emby/config:/config \
-v /home/wwwroot/Cloud:/mnt/share \
-v /home/wwwroot/sharep/share:/mnt/sharep \
--restart=always \
emby/embyserver_arm64v8:latest
```
## BUYVM
- Emby
```
  emby:
    image: emby/embyserver
    container_name: emby
    environment:
      - PUID=0
      - PGID=0
      - TZ=Asia/Shanghai
      - GIDLIST=0
    ports:
      - 1900:1900
      - 7359:7359/udp
      - 8099:8096
      - 8920:8920
    volumes:
      - /home/wwwroot/docker/emby/config:/config
      - /home/wwwroot/Cloud:/mnt/share
      - /home/wwwroot/p:/mnt/sharep
    restart: always
```
- mkvtoolnix
```
  mkvtoolnix:
    image: jlesage/mkvtoolnix
    container_name: mkvtoolnix
    environment:
      - ENABLE_CJK_FONT=1
      - PUID=0
      - PGID=0
    ports:
      - 5800:5800
    volumes:
      - /home/wwwroot/docker/mkvtoolnix:/config:rw
      - /home/qb/downloads:/storage:rw
    restart: always
```
```
chmod -R 777 /storage
```
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
- CF优选IP
```
docker run -d -v /cf/config:/app/config --name CloudflareSpeedTestDDNS lee1080/cfstddns:latest
编辑config
docker restart CloudflareSpeedTestDDNS
```
## chatgpt
```
https://chat.openai.com/api/auth/session
```
```
docker run \
--name chatgpt-web \
-p 3002:3002 \
--restart=always \
--env OPENAI_ACCESS_TOKEN= \
--env API_REVERSE_PROXY=http://w.199301.xyz:7999/chatgpt/backend-api/conversation \
ykj363963169/chatgpt-web:latest
```
```
docker run \
-d --name go-chatgpt-api \
-p 7999:8080 \
-v /var/run/docker.sock:/var/run/docker.sock:ro \
-e TZ=Asia/Shanghai \
--restart unless-stopped \
maxduke/go-chatgpt-api
```
```
http://ip:port/har/upload
```
## Emby恢复
``` 
zip -r emby.zip emby
systemctl stop emby-server
rm -rf /var/lib/emby
rclone copy banana:share/emby.zip /var/lib -v
unzip emby.zip
chown -R emby:emby /var/lib/emby
reboot
```
```
    <link rel='stylesheet' id='theme-css'  href='style.css' type='text/css' media='all' />
    <script src="common-utils.js"></script>
    <script src="jquery-3.6.0.min.js"></script>
    <script src="md5.min.js"></script>
    <script src="main.js"></script>
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
https://raw.githubusercontent.com/yenkj/ssr_subscrible_tool/master/script.conf
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
## xteve
```
docker run \
-d \
--name=xteve \
--net=host \
--log-opt max-size=10m \
--log-opt max-file=3 \
-e TZ="Asia/Shanghai" \
-v /volume1/docker/xteve/:/root/.xteve:rw \
-v /volume1/docker/xteve/_config/:/config:rw \
-v /volume1/docker/xteve/_guide2go/:/guide2go:rw \
-v /volume1/docker/xteve/tmp/:/tmp/xteve:rw \
-v /volume1/docker/m3u/:/mnt \
--restart=always
alturismo/xteve_guide2go
```
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
## 流媒体解锁检测
```
bash <(curl -L -s https://raw.githubusercontent.com/lmc999/RegionRestrictionCheck/main/check.sh) -M -4
```
```
[Script]
EmbyPremiere = type=http-response,script-path=https://gitlab.com/iptv-org/embypublic/-/raw/master/Script/EmbyPremiere.js,pattern=^https?:\/\/mb3admin.com\/admin\/service\/registration\/validateDevice,max-size=131072,requires-body=true,timeout=10,enable=true
[MITM]
hostname = mb3admin.com
```
```
[URL Rewrite]
(?<=_region=)CN(?=&) JP 307
(?<=&mcc_mnc=)4 2 307
^(https?:\/\/(tnc|dm)[\w-]+\.\w+\.com\/.+)(\?)(.+) $1$3 302
(^https?:\/\/*\.\w{4}okv.com\/.+&.+)(\d{2}\.3\.\d)(.+) $118.0$3 302
 
[MITM]
hostname = *.tiktokv.com,*.byteoversea.com,*.tik-tokapi.com
```
