# Copyright 2021-2025 Variscite
#
# SPDX-License-Identifier: BSD-3-Clause

# Network configuration file that enables DHCP for dynamic IP
# assignment on network interfaces.

dhcp_config:
	@[ $(SOCFAMILY) != IMX -o $(DISTROVARIANT) = base -o $(DISTROVARIANT) = tiny ] && exit || \
	$(call fbprint_b,"dhcp_config") && \
	if [ ! -d $(PKGDIR)/apps/connectivity/dhcp_config ]; then \
		mkdir -p $(PKGDIR)/apps/connectivity/dhcp_config; \
	fi; \
	echo "[Match]" > $(PKGDIR)/apps/connectivity/dhcp_config/10-dhcp-all.network && \
	echo "Name=*" >> $(PKGDIR)/apps/connectivity/dhcp_config/10-dhcp-all.network && \
	echo "" >> $(PKGDIR)/apps/connectivity/dhcp_config/10-dhcp-all.network && \
	echo "[Network]" >> $(PKGDIR)/apps/connectivity/dhcp_config/10-dhcp-all.network && \
	echo "DHCP=yes" >> $(PKGDIR)/apps/connectivity/dhcp_config/10-dhcp-all.network && \
	install -d $(DESTDIR)/etc/systemd/network && \
	install -m 0644 $(PKGDIR)/apps/connectivity/dhcp_config/10-dhcp-all.network $(DESTDIR)/etc/systemd/network && \
	$(call fbprint_d,"dhcp_config") \
