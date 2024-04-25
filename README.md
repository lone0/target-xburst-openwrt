# OpenWrt Target for Ingenic Xburst SoC

This repo adds a target to OpenWrt for Xburst SoC X2000

## Getting Started

### 1. Clone the OpenWrt Repository
   
   ```bash
   git clone https://github.com/openwrt/openwrt.git
   cd openwrt
   ```

**Note:** Ensure that you are working with the `main` branch, as this target is compatible with it. For example:
   ```
   commit b463737826eaa6c519eba93e13757a0cd3e09d47 (HEAD -> main)
   Author: Yuu Toriyama <PascalCoffeeLake@gmail.com>
   Date:   Sun Feb 4 04:09:14 2024 +0900
   
       wireless-regdb: update to 2024.01.23
   
       The maintainer and repository of wireless-regdb has changed.
           https://lore.kernel.org/all/CAGb2v657baNMPKU3QADijx7hZa=GUcSv2LEDdn6N=QQaFX8r-g@mail.gmail.com/
   ```

### 2. Add Custom Feed

   ```bash
   echo src-git xburst https://github.com/lone0/target-xburst-openwrt.git >> feeds.conf
   ./scripts/feeds update xburst
   ./scripts/feeds install xburst
   ```
**Verify Installation:**

 ```bash
 $ ls target/linux/feeds/xburst
 Makefile  base-files  config-6.1  halley5  halley5_defconfig  image  modules.mk  patches-6.1  qi_lb60
 ```

### 3. Build the code

   ```base
   cp target/linux/feeds/xburst/halley5_defconfig .config
   make defconfig
   make menuconfig
   ```

**Customization:**

Modify configurations using `menuconfig` and then:

   ```
   make -j$(nproc)
   ```

   This process takes time. Upon completion, the following files will be generated:
   
- `bin/targets/xburst/halley5/openwrt-xburst-halley5-uImage.bin`
- `bin/targets/xburst/halley5/openwrt-xburst-halley5-root.ext4`

   These files are ready for flashing onto the device using `cloner`


### 4. Enable WiFi on the Device

After flashing the kernel and root filesystem, WiFi is disabled by default. To enable it, access the console of x2000 device:

   ```bash
   uci set wireless.radio0.disabled=0
   uci commit wireless
   service network restart
   ```
Check for the 'OpenWrt' WiFi signal on your mobile device.

### 5. Enable 4G Modem on the Device
Append the following configuration to `/etc/config/network`:

   ```base
   config interface 'wwan'
        option proto 'qmi'
        option device '/dev/cdc-wdm0'
        option apn 'ctnet'
        option pdptype 'ip'
   ```

Replace `'ctnet'` with your cellular carrier's APN.

Update `/etc/config/firewall` to add the `wwan` interface to the "wan" firewall zone:

   ```
   config zone
       option name 'wan'
       [...]
       list network 'wwan'
   ```

   Restart the network service to apply the changes.

   That's it! Your OpenWrt installation with support for the Ingenic Xburst SoC should now be up and running.
    
