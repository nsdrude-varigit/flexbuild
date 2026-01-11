# Copyright 2021-2025 Variscite
#
# SPDX-License-Identifier: BSD-3-Clause


# Startup and config files for use with IW612 wireless module

IW612_UTILS ?= "true"

iw612_utils:
	@[ $(SOCFAMILY) != IMX -o $(DISTROVARIANT) = base -o $(DISTROVARIANT) = tiny -o $(IW612_UTILS) = false ] && exit || \
	$(call fbprint_b,"iw612_utils") && \
	$(call repo-mngr,fetch,meta_variscite_bsp_imx) && \
	$(call repo-mngr,fetch,meta_variscite_bsp_common) && \
	IW612_DIR="$(PKGDIR)/meta_variscite_bsp_imx/recipes-connectivity/iw612-utils/iw612-utils/" && \
	mkdir -p $(FBOUTDIR)/bsp/iw612_firmware/lib/firmware/nxp && \
	cp -Prf $(PKGDIR)/meta_variscite_bsp_common/recipes-connectivity/iw612-utils/iw612-utils/var_wifi_mod_para.conf $(FBOUTDIR)/bsp/iw612_firmware/lib/firmware/nxp/ && \
	install -d $(DESTDIR)/etc/bluetooth/variscite-bt.d && \
	install -d $(DESTDIR)/etc/wifi/variscite-wifi.d && \
	install -m 0755 $$IW612_DIR/$(MACHINE)/iw612-bt $(DESTDIR)/etc/bluetooth/variscite-bt.d && \
	install -m 0755 $$IW612_DIR/$(MACHINE)/iw612-wifi $(DESTDIR)/etc/wifi/variscite-wifi.d && \
	$(call fbprint_d,"iw612_utils") \
