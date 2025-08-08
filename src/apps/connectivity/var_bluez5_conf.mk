# Copyright 2021-2025 Variscite
#
# SPDX-License-Identifier: BSD-3-Clause


# Variscite WiFi + Bluetooth
CONNECTIVITY_VAR_BLUEZ5 ?= true

var_bluez5_conf:
	@[ $(SOCFAMILY) != IMX -o $(DISTROVARIANT) = base -o $(DISTROVARIANT) = tiny -o $(CONNECTIVITY_VAR_BLUEZ5) = false ] && exit || \
	$(call fbprint_b,"var_bluez5_conf") && \
	$(call repo-mngr,fetch,meta_variscite_bsp_common) && \
	BLUEZ_DIR="$(PKGDIR)/meta_variscite_bsp_common/recipes-connectivity/bluez5/files" && \
	install -d $(DESTDIR)/etc/bluetooth && \
	install -d $(DESTDIR)/etc/dbus-1/system.d && \
	install -d $(DESTDIR)/etc/profile.d && \
	install -d $(DESTDIR)/etc/systemd/system && \
	install -d $(DESTDIR)/etc/systemd/system/multi-user.target.wants && \
	install -m 0644 $$BLUEZ_DIR/audio.conf $(DESTDIR)/etc/bluetooth && \
	install -m 0644 $$BLUEZ_DIR/main.conf $(DESTDIR)/etc/bluetooth && \
	install -m 0644 $$BLUEZ_DIR/obexd.conf $(DESTDIR)/etc/dbus-1/system.d && \
	install -m 0644 $$BLUEZ_DIR/obex.service $(DESTDIR)/etc/systemd/system && \
	install -m 0644 $$BLUEZ_DIR/bluetooth.service $(DESTDIR)/etc/systemd/system && \
	ln -sf $(DESTDIR)/etc/systemd/system/obex.service \
		$(DESTDIR)/etc/systemd/system/multi-user.target.wants/obex.service && \
	$(call fbprint_d,"var_bluez5_conf") \
