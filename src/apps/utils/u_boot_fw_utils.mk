# Copyright 2021-2025 Variscite
#
# SPDX-License-Identifier: BSD-3-Clause

u_boot_fw_utils:
	@[ $(SOCFAMILY) != IMX -o $(DISTROVARIANT) = base -o $(DISTROVARIANT) = tiny ] && exit || \
	$(call fbprint_b,"u_boot_fw_utils") && \
	$(call repo-mngr,fetch,meta_variscite_bsp_imx) && \
	FWUTILS_DIR="$(PKGDIR)/meta_variscite_bsp_imx/recipes-bsp/u-boot/u-boot-variscite" && \
	install -d $(DESTDIR)/etc && \
	install -m 0644 $$FWUTILS_DIR/$(MACHINE)/fw_env.config $(DESTDIR)/etc/ && \
	$(call fbprint_d,"u_boot_fw_utils")
