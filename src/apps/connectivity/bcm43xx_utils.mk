# Copyright 2021-2025 Variscite
#
# SPDX-License-Identifier: BSD-3-Clause


# Variscite WiFi + Bluetooth


bcm43xx_utils:
	@[ $(SOCFAMILY) != IMX -o $(DISTROVARIANT) = base -o $(DISTROVARIANT) = tiny ] && exit || \
	$(call fbprint_b,"bcm43xx_utils") && \
	$(call repo-mngr,fetch,meta_variscite_bsp_imx) && \
	BCM_DIR="$(PKGDIR)/meta_variscite_bsp_imx/recipes-connectivity/bcm43xx-utils/bcm43xx-utils/$(MACHINE)" && \
	install -d $(DESTDIR)/etc/bluetooth/variscite-bt.d && \
	install -d $(DESTDIR)/etc/wifi/variscite-wifi.d && \
	install -m 0755 $$BCM_DIR/bcm43xx-bt $(DESTDIR)/etc/bluetooth/variscite-bt.d && \
	install -m 0755 $$BCM_DIR/bcm43xx-wifi $(DESTDIR)/etc/wifi/variscite-wifi.d && \
	$(call fbprint_d,"bcm43xx_utils") \
