# Copyright 2021-2025 Variscite
#
# SPDX-License-Identifier: BSD-3-Clause


# Firmware for WL18XX WIFI+BT modules

FIRMWARE_WL18XX ?= false

wl18xx_firmware:
	@[ $(SOCFAMILY) != IMX -o $(DISTROVARIANT) = base -o $(DISTROVARIANT) = tiny -o $(FIRMWARE_WL18XX) = false ] && exit || \
	$(call fbprint_b,"wl18xx_firmware") && \
	$(call repo-mngr,fetch,wl18xx_firmware,bsp) && \
	$(call repo-mngr,fetch,tibt_firmware,bsp) && \
	mkdir -p $(FBOUTDIR)/bsp/wl18xx_firmware/lib/firmware/ti-connectivity && \
	cp -f $(BSPDIR)/tibt_firmware/initscripts/TIInit_*.bts $(FBOUTDIR)/bsp/wl18xx_firmware/lib/firmware/ti-connectivity && \
	cp -f $(BSPDIR)/wl18xx_firmware/*.bin $(FBOUTDIR)/bsp/wl18xx_firmware/lib/firmware/ti-connectivity && \
	cp -f $(PKGDIR)/meta_variscite_bsp_imx/recipes-kernel/linux-firmware/files/wl1271-nvs.bin $(FBOUTDIR)/bsp/wl18xx_firmware/lib/firmware/ti-connectivity && \
	$(call fbprint_d,"wl18xx_firmware") \
