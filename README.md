# OpenWrt Target for Ingenic XBurst SoC

OpenWrt target for Ingenic X2000 (XBurst2) SoC, built on top of **OpenWrt 24.10** with the **Linux 6.6.151 mainline kernel**.

**Tested on: Ingenic Halley5 (X2000) board** — boots, runs, WiFi functional.

## Getting Started

### 1. Clone OpenWrt

```bash
git clone https://github.com/openwrt/openwrt.git
cd openwrt
git checkout v24.10.0
```

### 2. Add Custom Feed

```bash
echo src-git xburst https://github.com/lone0/target-xburst-openwrt.git >> feeds.conf
./scripts/feeds update xburst
./scripts/feeds install -p xburst -a
```

**Verify installation:**

```
$ ls target/linux/xburst/
Makefile  base-files  config-6.6  halley5  image  modules.mk  patches-6.6  qi_lb60
```

### 3. Build

```bash
make menuconfig
```

In `menuconfig`:
- Target System: `Ingenic XBurst`
- Target Profile: select your board (e.g. `Halley5 (X2000)`)

```bash
make -j$(nproc)
```

This process takes time. On completion, the following files will be generated:

```
bin/targets/xburst/halley5/
├── openwrt-xburst-halley5-uImage.bin
└── openwrt-xburst-halley5-root.ext4
```

These files are ready for flashing onto the device using `cloner`.

### 4. Enable WiFi on the Device

After flashing, WiFi is disabled by default. Access the device console:

```bash
uci set wireless.radio0.disabled=0
uci commit wireless
service network restart
```

Check for the "OpenWrt" WiFi signal on your mobile device.

### 5. Enable 4G Modem on the Device

Append the following to `/etc/config/network`:

```
config interface 'wwan'
    option proto 'qmi'
    option device '/dev/cdc-wdm0'
    option apn 'ctnet'
    option pdptype 'ip'
```

Replace `'ctnet'` with your carrier's APN.

Add the `wwan` interface to the "wan" zone in `/etc/config/firewall`:

```
config zone
    option name 'wan'
    [...]
    list network 'wwan'
```

Restart the network service. That's it!
