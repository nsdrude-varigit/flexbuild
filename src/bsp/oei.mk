#
# Copyright 2025 Variscite
#
# SPDX-License-Identifier: BSD-3-Clause
#

# build OEI binaries for i.MX95 platforms

oei imx-oei:
	@[ $${MACHINE:0:5} != imx95 ] && exit || \
	if [ ! -d $(BSPDIR)/oei ]; then \
		$(call fbprint_b,"imx-oei") && \
		$(call repo-mngr,fetch,oei,bsp) \
	fi && \
        if [ ! -d $(PKGDIR)/apps/utils/cortexm_toolchain_cross/bin ]; then \
                bld cortexm_toolchain_cross -r $(DISTROTYPE):$(DISTROVARIANT) -a $(DESTARCH); \
        fi && \
	cd $(BSPDIR)/oei && \
	export OEI_CROSS_COMPILE=$(PKGDIR)/apps/utils/cortexm_toolchain_cross/bin/arm-none-eabi- && \
	make really-clean && \
	make board=mx95-var-dart DEBUG=0 r=B0 oei=ddr && \
	make board=mx95-var-dart DEBUG=0 r=B0 oei=tcm && \
	$(call fbprint_d,"IMX OEI for $(MACHINE)")
