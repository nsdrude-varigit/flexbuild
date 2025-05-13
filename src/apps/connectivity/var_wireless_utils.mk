# Copyright 2021-2025 Variscite
#
# SPDX-License-Identifier: BSD-3-Clause


# Variscite WiFi + Bluetooth


var_wireless_utils:
	@[ $(SOCFAMILY) != IMX -o $(DISTROVARIANT) = base -o $(DISTROVARIANT) = tiny ] && exit || \
	$(call fbprint_b,"var_wireless_utils") && \
	$(call repo-mngr,fetch,meta_variscite_bsp_common) && \
	WIFI_UTILS_DIR="$(PKGDIR)/meta_variscite_bsp_common/recipes-connectivity/var-wireless-utils/var-wireless-utils" && \
	install -d $(DESTDIR)/etc/wifi && \
	install -d $(DESTDIR)/etc/bluetooth && \
	install -d $(DESTDIR)/etc/openthread && \
	install -d $(DESTDIR)/etc/systemd/system && \
	install -d $(DESTDIR)/etc/systemd/system/multi-user.target.wants && \
	install -m 0755 $$WIFI_UTILS_DIR/variscite-wifi $(DESTDIR)/etc/wifi && \
	install -m 0644 $$WIFI_UTILS_DIR/variscite-wireless $(DESTDIR)/etc/wifi && \
	install -m 0755 $$WIFI_UTILS_DIR/variscite-bt $(DESTDIR)/etc/bluetooth && \
	install -m 0755 $$WIFI_UTILS_DIR/variscite-ot $(DESTDIR)/etc/openthread && \
	install -m 0755 $$WIFI_UTILS_DIR/variscite-ot-server $(DESTDIR)/etc/openthread && \
	install -m 0755 $$WIFI_UTILS_DIR/variscite-ot-client $(DESTDIR)/etc/openthread && \
	install -m 0644 $$WIFI_UTILS_DIR/variscite-wifi.service $(DESTDIR)/etc/systemd/system && \
	install -m 0644 $$WIFI_UTILS_DIR/variscite-bt.service $(DESTDIR)/etc/systemd/system && \
	install -m 0644 $$WIFI_UTILS_DIR/variscite-ot.service $(DESTDIR)/etc/systemd/system && \
	ln -sf $(DESTDIR)/etc/systemd/system/variscite-wifi.service \
		$(DESTDIR)/etc/systemd/system/multi-user.target.wants/variscite-wifi.service && \
	ln -sf $(DESTDIR)/etc/systemd/system/variscite-bt.service \
		$(DESTDIR)/etc/systemd/system/multi-user.target.wants/variscite-bt.service && \
	ln -sf $(DESTDIR)/etc/systemd/system/variscite-ot.service \
		$(DESTDIR)/etc/systemd/system/multi-user.target.wants/variscite-ot.service && \
	ln -sf $(DESTDIR)/etc/system/wpa_supplicant@.service \
		$(DESTDIR)/etc/systemd/system/multi-user.target.wants/wpa_supplicant@wlan0.service && \
	$(call fbprint_d,"var_wireless_utils") \
