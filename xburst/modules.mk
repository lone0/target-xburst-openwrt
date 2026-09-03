# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (c) 2022 Tomasz Maciej Nowak <tmn505@gmail.com>

define KernelPackage/phy-ingenic-usb
  SUBMENU := $(USB_MENU)
  TITLE := Ingenic SoCs USB PHY
  CONFLICTS := kmod-usb-phy-ingenic
  DEPENDS:= @TARGET_xburst
  KCONFIG := CONFIG_PHY_INGENIC_USB
  FILES := $(LINUX_DIR)/drivers/phy/ingenic/phy-ingenic-usb.ko
  AUTOLOAD := $(call AutoLoad,21,phy-ingenic-usb,1)
endef

define KernelPackage/phy-ingenic-usb/description
  Supports Ingenic SoC USB PHY starting from JZ4770.
endef

$(eval $(call KernelPackage,phy-ingenic-usb))
