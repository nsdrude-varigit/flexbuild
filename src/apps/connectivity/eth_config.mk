# Copyright 2021-2025 Variscite
#
# SPDX-License-Identifier: BSD-3-Clause

# File configuration to change interface names from end* to eth*,
# to follow the same pattern as yocto images

eth_config:
	@[ $(SOCFAMILY) != IMX -o $(DISTROVARIANT) = base -o $(DISTROVARIANT) = tiny ] && exit || \
	$(call fbprint_b,"eth_config") && \
	if [ ! -d $(PKGDIR)/apps/connectivity/eth_config ]; then \
		mkdir -p $(PKGDIR)/apps/connectivity/eth_config; \
	fi; \
	echo "[Match]" > $(PKGDIR)/apps/connectivity/eth_config/99-default.link && \
	echo "OriginalName=end*" >> $(PKGDIR)/apps/connectivity/eth_config/99-default.link && \
	echo "" >> $(PKGDIR)/apps/connectivity/eth_config/99-default.link && \
	echo "[Link]" >> $(PKGDIR)/apps/connectivity/eth_config/99-default.link && \
	echo "NamePolicy=keep" >> $(PKGDIR)/apps/connectivity/eth_config/99-default.link && \
	echo "Name=eth%n" >> $(PKGDIR)/apps/connectivity/eth_config/99-default.link && \
	install -d $(DESTDIR)/etc/systemd/network && \
	install -m 0644 $(PKGDIR)/apps/connectivity/eth_config/99-default.link $(DESTDIR)/etc/systemd/network && \
	$(call fbprint_d,"eth_config") \
