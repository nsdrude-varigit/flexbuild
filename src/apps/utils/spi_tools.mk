# Copyright 2025 Variscite Ltd.
#
# SPDX-License-Identifier: BSD-3-Clause

# Linux tools

# Depends on linux


spi_tools:
	 @$(call repo-mngr,fetch,$(KERNEL_TREE),linux) && \
	 cd $(PKGDIR)/linux && \
	 curbrch=`cd $(KERNEL_PATH) && git branch | grep ^* | cut -d' ' -f2` && \
	 opdir=$(KERNEL_OUTPUT_PATH)/$$curbrch && \
	 $(call fbprint_b,"kernel tools/perf") && \
	 mkdir -p $$opdir && \
	 if [ ! -f $$opdir/.config ]; then \
	     $(MAKE) $(KERNEL_CFG) -C $(KERNEL_PATH) O=$$opdir 1>/dev/null; \
	 fi && \
	 export CC="$(CROSS_COMPILE)gcc --sysroot=$(RFSDIR)" && \
	 $(MAKE) -j$(JOBS) tools/spi -C $(KERNEL_PATH) O=$$opdir && \
	 install -d $(DESTDIR)/usr/bin && \
	 install -m 0755 $$opdir/tools/spi/spidev_test $(DESTDIR)/usr/bin/spidev_test && \
	 $(call fbprint_d,"kernel tools/spi")
