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
FEATURES:=targz usb ext4 fpu
SUBTARGETS:=halley5 qi_lb60

KERNEL_PATCHVER:=6.1

DEVICE_TYPE:=other

define Target/Description
	Build firmware images for Ingenic XBurst X-series SoC based boards.
endef

include $(INCLUDE_DIR)/target.mk

define Kernel/Prepare/Default
	$(LINUX_CAT) $(DL_DIR)/$(LINUX_SOURCE) | $(TAR) -C $(KERNEL_BUILD_DIR) $(TAR_OPTIONS)
	$(call PatchDir,$(LINUX_DIR),$(PATCH_DIR),platform/)
endef


$(eval $(call BuildTarget))
