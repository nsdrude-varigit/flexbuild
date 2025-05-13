# Copyright 2021-2025 Variscite
#
# SPDX-License-Identifier: BSD-3-Clause


# Variscite udev scripts

udev_extraconf:
	@[ $(SOCFAMILY) != IMX -o $(DISTROVARIANT) = base -o $(DISTROVARIANT) = tiny ] && exit || \
	$(call fbprint_b,"udev_extraconf") && \
	install -d $(DESTDIR)/etc/udev/rules.d && \
	install -d $(DESTDIR)/etc/udev/scripts && \
	install -d $(DESTDIR)/etc/udev/mount.ignorelist.d && \
	install -d $(DESTDIR)/etc/modprobe.d && \
	install -m 0644 $(FBDIR)/src/system/udev-extraconf/automount.rules $(DESTDIR)/etc/udev/rules.d/automount.rules && \
	install -m 0644 $(FBDIR)/src/system/udev-extraconf/mount.ignorelist $(DESTDIR)/etc/udev/mount.ignorelist && \
	install -m 0644 $(FBDIR)/src/system/udev-extraconf/variscite-blacklist.conf $(DESTDIR)/etc/modprobe.d/variscite-blacklist.conf && \
	install -m 0755 $(FBDIR)/src/system/udev-extraconf/mount.sh $(DESTDIR)/etc/udev/scripts/mount.sh && \
	$(call fbprint_d,"udev_extraconf") \
