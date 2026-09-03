#
# Copyright (C) 2009-2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk

ARCH:=mipsel
BOARD:=xburst
BOARDNAME:=Ingenic XBurst
CPU_TYPE:=mips32
FEATURES:=targz usb ext4 fpu
SUBTARGETS:=halley5 qi_lb60

KERNEL_PATCHVER:=6.6

define Target/Description
	Build firmware images for Ingenic XBurst X-series SoC based boards.
endef

include $(INCLUDE_DIR)/target.mk

DEFAULT_PACKAGES += e2fsprogs kmod-fs-vfat kmod-brcmfmac wpad-basic-mbedtls \
        kmod-usb-dwc2 partx-utils kmod-phy-ingenic-usb

$(eval $(call BuildTarget))
