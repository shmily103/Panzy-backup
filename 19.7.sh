echo '获取openwrt源码仓'
git clone https://git.openwrt.org/openwrt/openwrt.git -b v19.07.8
echo '进入openwrt文件夹'
cd openwrt
echo '更新openwrt依赖库'
./scripts/feeds update -a
./scripts/feeds install -a
echo '获取自定义软件源'
git clone https://github.com/shmily103/Panzy package/Panzy
echo '更换自定义配置文件'
[ -e package/Panzy/config/19.7.config ] && mv package/Panzy/config/19.7.config .config
echo '修改默认管理IP'
sed -i 's/192.168.1.1/192.168.6.1/g' package/base-files/files/bin/config_generate
echo '修改WIFI为开启'
sed -i 's/disabled=1/disabled=0/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
echo '修改默认WIFI名称'
sed -i 's/ssid=OpenWrt/ssid=Panzy/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
echo '修改自动挂载硬盘配置文件'
\cp -rf package/Panzy/mount.hotplug package/system/fstools/files
echo '修改网易云解锁软件的奇妙BUG'
chmod a+x package/Panzy/luci-app-unblockneteasemusic/root/etc/init.d/unblockneteasemusic
echo '更新GO版本'
rm -rf feeds/packages/lang/golang
rm -rf package/feeds/packages/golang
cp -rf package/Panzy/golang feeds/packages/lang/golang
echo '加载配置'
make defconfig
echo '下载预编译源码包'
make download -j8
echo '开始编译固件'
make -j3 V=99
