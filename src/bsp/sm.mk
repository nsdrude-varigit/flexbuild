#
# Copyright 2025 Variscite
#
# SPDX-License-Identifier: BSD-3-Clause
#

# build the System Manager for i.MX5 platforms

SM_PLAT ?= mx95evk

sm imx-sm:
	@[ $${MACHINE:0:5} != imx95 ] && exit || \
	if [ ! -d $(BSPDIR)/sm ]; then \
		$(call fbprint_b,"imx-sm") && \
		$(call repo-mngr,fetch,sm,bsp) \
	fi && \
        if [ ! -d $(PKGDIR)/apps/utils/cortexm_toolchain_cross/bin ]; then \
                bld cortexm_toolchain_cross -r $(DISTROTYPE):$(DISTROVARIANT) -a $(DESTARCH); \
        fi && \
	cd $(BSPDIR)/sm && \
	export SM_CROSS_COMPILE=$(PKGDIR)/apps/utils/cortexm_toolchain_cross/bin/arm-none-eabi- && \
	make really-clean && \
	make -j $(nproc --all) config=$(SM_PLAT) cfg && \
	make -j $(nproc --all) config=$(SM_PLAT) img && \
	$(call fbprint_d,"IMX SM for $(MACHINE)")
