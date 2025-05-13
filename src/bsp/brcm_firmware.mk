# Copyright 2017-2024 NXP
#
# SPDX-License-Identifier: BSD-3-Clause


brcm_firmware:
	@[ $(SOCFAMILY) != IMX -o $(DISTROVARIANT) = base -o $(DISTROVARIANT) = tiny ] && exit || \
	$(call fbprint_b,"brcm_firmware") && \
	mkdir -p $(BSPDIR)/brcm_firmware && \
	cd $(BSPDIR)/brcm_firmware && \
	wget -q $(repo_brcm_lwb_firmware_url) -O laird-lwb-fcc-firmware-12.29.0.22.tar.bz2 && \
	wget -q $(repo_brcm_lwb5_firmware_url) -O laird-lwb5-fcc-firmware-12.29.0.22.tar.bz2 && \
	tar -xvjf laird-lwb-fcc-firmware-12.29.0.22.tar.bz2 && \
	tar -xvjf laird-lwb5-fcc-firmware-12.29.0.22.tar.bz2 && \
	cd $(BSPDIR)/brcm_firmware/lib/firmware/brcm && \
	for machine_sel in $(MACHINE_LIST); do \
		ln -sf brcmfmac4339-sdio.bin brcmfmac4339-sdio.variscite,$$machine_sel.bin && \
		ln -sf brcmfmac4339-sdio.txt brcmfmac4339-sdio.variscite,$$machine_sel.txt; \
	done && \
	mkdir -p $(FBOUTDIR)/bsp/brcm_firmware && \
	cp -rf $(BSPDIR)/brcm_firmware/lib $(FBOUTDIR)/bsp/brcm_firmware && \
	$(call fbprint_d,"brcm_firmware") \
