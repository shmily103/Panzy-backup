#!/bin/bash
#============================================================
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#============================================================

# Modify default IP
sed -i 's/192.168.1.1/192.168.6.1/g' package/base-files/files/bin/config_generate
# Modify WiFi ON
sed -i 's/disabled=1/disabled=0/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
# Modify default SSID
sed -i 's/ssid=OpenWrt/ssid=Panzy/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

#add packages
git clone https://github.com/shmily103/Panzy.git package/Panzy
# Modify Automount
\cp -rf package/Panzy/mount.hotplug package/system/fstools/files
# fix unblockmusic
chmod a+x package/Panzy/luci-app-unblockneteasemusic/root/etc/init.d/unblockneteasemusic

# rm -rf package/feeds/packages/kcptun

# rm -rf feeds/packages/lang/golang
# cp -rf package/Panzy/golang feeds/packages/lang/golang
rm -rf package/Panzy/golang
