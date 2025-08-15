# Copyright 2021-2025 Variscite
#
# SPDX-License-Identifier: BSD-3-Clause


# Config files for use with WL18XX wireless module

CONNECTIVITY_WL_CONF ?= false

wl_conf:
	@[ $(SOCFAMILY) != IMX -o $(DISTROVARIANT) = base -o $(DISTROVARIANT) = tiny -o $(CONNECTIVITY_WL_CONF) = false ] && exit || \
	$(call fbprint_b,"wlconf") && \
	$(call repo-mngr,fetch,wlconf,apps/connectivity) && \
	cd $(PKGDIR)/apps/connectivity/wlconf/wlconf && \
	export PKG_CONFIG_SYSROOT_DIR="$(RFSDIR)" && \
	export PKG_CONFIG_LIBDIR="$(RFSDIR)/usr/lib/$(ARM_LINUX_GNU_TOOLCHAIN)/pkgconfig:$(RFSDIR)/usr/lib/pkgconfig:$(RFSDIR)/usr/share/pkgconfig" && \
	make CC="$(ARM_LINUX_GNU_TOOLCHAIN)-gcc \
		-mthumb \
		-mfpu=neon \
		-mfloat-abi=hard \
		-mcpu=cortex-a9 \
		-fstack-protector-strong \
		-O2 \
		-D_FORTIFY_SOURCE=2 \
		-Wformat \
		-Wformat-security \
		-Werror=format-security \
		-D_TIME_BITS=64 \
		-D_FILE_OFFSET_BITS=64 \
		-I$(RFSDIR)/usr/include/libnl3 \
		--sysroot=$(RFSDIR)" && \
	install -d $(DESTDIR)/sbin/wlconf && \
	install -d $(DESTDIR)/sbin/wlconf/official_inis && \
	install -d $(DESTDIR)/usr/lib/firmware/ti-connectivity && \
	install -m 0755 wlconf $(DESTDIR)/sbin/wlconf/ && \
	install -m 0755 dictionary.txt $(DESTDIR)/sbin/wlconf/ && \
	install -m 0755 struct.bin $(DESTDIR)/sbin/wlconf/ && \
	install -m 0755 default.conf $(DESTDIR)/sbin/wlconf/ && \
	install -m 0755 wl18xx-conf-default.bin $(DESTDIR)/sbin/wlconf/ && \
	install -m 0755 wl18xx-conf-default.bin $(DESTDIR)/usr/lib/firmware/ti-connectivity/wl18xx-conf.bin && \
	install -m 0755 README $(DESTDIR)/sbin/wlconf/ && \
	install -m 0755 example.conf $(DESTDIR)/sbin/wlconf/ && \
	install -m 0755 example.ini $(DESTDIR)/sbin/wlconf/ && \
	install -m 0755 configure-device.sh $(DESTDIR)/sbin/wlconf/ && \
	install -m 0755 official_inis/* $(DESTDIR)/sbin/wlconf/official_inis/ && \
	$(call fbprint_d,"wlconf") \
