# OpenWrt target for Ingenic Xburst SoC

This repo adds a target to OpenWrt for Xburst SoC X2000

## Usage

1. Clone OpenWrt
   
   ```
   git clone https://github.com/openwrt/openwrt.git
   cd openwrt
   ```

   As of today, I work with master branch:

```
commit b463737826eaa6c519eba93e13757a0cd3e09d47 (HEAD -> main)
Author: Yuu Toriyama <PascalCoffeeLake@gmail.com>
Date:   Sun Feb 4 04:09:14 2024 +0900

    wireless-regdb: update to 2024.01.23

    The maintainer and repository of wireless-regdb has changed.
        https://lore.kernel.org/all/CAGb2v657baNMPKU3QADijx7hZa=GUcSv2LEDdn6N=QQaFX8r-g@mail.gmail.com/
```

2. Add feed

   ```
   echo src-git xburst https://github.com/lone0/target-xburst-openwrt.git >> feeds.conf
   ./scripts/feeds update xburst
   ./scripts/feeds install xburst
   ```

   And check if xburst is installed:

    ```
    $ ls target/linux/feeds/xburst
    Makefile  base-files  config-6.1  halley5  halley5_defconfig  image  modules.mk  patches-6.1  qi_lb60
    ```

3. Build

   ```
   cp target/linux/feeds/xburst/halley5_defconfig .config
   make defconfig
   make menuconfig
   ```

   And do your own customization in the menuconfig

   ```
   make -jN
   ```

   And wait a long time. In the end you will have:
   
   bin/targets/xburst/halley5/openwrt-xburst-halley5-uImage.bin<br>
   bin/targets/xburst/halley5/openwrt-xburst-halley5-root.ext4

   They are ready for cloner to do the device flash.


4. Enable WiFi on device
   Once the kernel and rootfs are flashed and device is up, the WiFi is disabled by default. Now on the console of the device (halley5 evboard), type the following:

   ```
   uci set wireless.radio0.disabled=0
   uci commit wireless
   service network restart
   ```

   Now check on your phone whether WiFi signal 'OpenWrt' is available.

5. Enable 4G Modem on device
   Edit /etc/config/network and append the following section:

   ```
   config interface 'wwan'
        option proto 'qmi'
        option device '/dev/cdc-wdm0'
        option apn 'ctnet'
        option pdptype 'ip'
   ```

   Replace the apn name with the one from your cellular carrier.

   Edit /etc/config/firewall and add interface wwan to "wan" firewall zone:

   ```
   config zone
       option name 'wan'
       [...]
       list network 'wwan'
   ```

   Again restart the service network.

   All done, enjoy.
    
