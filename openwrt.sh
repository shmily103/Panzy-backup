git clone https://git.openwrt.org/openwrt/openwrt.git -b v21.02.0
cd openwrt
git clone https://github.com/shmily103/Panzy package/Panzy

./scripts/feeds update -a
./scripts/feeds install -a

# [ -e $CONFIG_FILE ] && mv $CONFIG_FILE openwrt/.config
[ -e package/Panzy/config/21.02.config ] && mv package/Panzy/config/21.02.config .config
sed -i 's/192.168.1.1/192.168.6.1/g' package/base-files/files/bin/config_generate
sed -i 's/disabled=1/disabled=0/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
sed -i 's/ssid=OpenWrt/ssid=Panzy/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
\cp -rf package/Panzy/mount.hotplug package/system/fstools/files
chmod a+x package/Panzy/luci-app-unblockneteasemusic/root/etc/init.d/unblockneteasemusic
rm -rf feeds/packages/lang/golang
cp -rf package/Panzy/golang feeds/packages/lang/golang
make defconfig
make download -j8
make V=s
