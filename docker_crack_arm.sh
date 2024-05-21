#!/bin/bash
echo "docker一键**脚本，适4.8.7.0版本"
echo "-------------------web端**-------------------"
rm -f /system/Emby.Web.dll
wget -P /system/ http://w.199301.xyz:9867/share/emby/arm/Emby.Web.dll
rm -f /system/MediaBrowser.Model.dll
wget -P /system/ http://w.199301.xyz:9867/share/emby/arm/MediaBrowser.Model.dll
echo "核心**完成..."
rm -f /system/dashboard-ui/modules/emby-apiclient/connectionmanager.js
wget -P /system/dashboard-ui/modules/emby-apiclient/ http://w.199301.xyz:9867/share/emby/arm/dashboard-ui/modules/emby-apiclient/connectionmanager.js
rm -f /system/dashboard-ui/embypremiere/embypremiere.js
wget -P /system/dashboard-ui/embypremiere/ http://w.199301.xyz:9867/share/emby/arm/dashboard-ui/embypremiere/embypremiere.js
echo "web**完成..."
rm -f /system/Emby.Server.Implementations.dll
wget -P /system/ http://w.199301.xyz:9867/share/emby/arm/Emby.Server.Implementations.dll
echo "Implementations替换认证..."

