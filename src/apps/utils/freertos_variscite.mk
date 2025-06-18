# Copyright 2021-2025 Variscite
#
# SPDX-License-Identifier: BSD-3-Clause
#
# Variscite FreeRTOS

CM_GCC = "12.3.rel1"

# Firmware source directories
DEMO_LIST = multicore_examples/rpmsg_lite_str_echo_rtos multicore_examples/rpmsg_lite_pingpong_rtos/linux_remote demo_apps/hello_world
CM_BUILD_TARGETS = debug ddr_debug

freertos_variscite:
	@[ $(SOCFAMILY) != IMX -o $(DISTROVARIANT) = base -o $(DISTROVARIANT) = tiny ] && exit || \
	$(call fbprint_b,"freertos_variscite") && \
	$(call repo-mngr,fetch,freertos_variscite,apps/utils) && \
	$(call repo-mngr,fetch,meta_variscite_bsp_imx) && \
	export ARMGCC_DIR=$(PKGDIR)/apps/utils/cortexm_toolchain_cross && \
	if [ ! -d $(PKGDIR)/$$ARMGCC_DIR/bin/arm-none-eabi-gcc ]; then \
	 	bld cortexm_toolchain_cross -r $(DISTROTYPE):$(DISTROVARIANT) -a $(DESTARCH); \
	fi && \
	mkdir -p $(PKGDIR)/apps/utils/freertos_variscite && \
	cd $(PKGDIR)/apps/utils/freertos_variscite && \
	for CM_DEMO in $(DEMO_LIST); do \
	  for BOARD_SEL in $(CM_BOARD); do \
			DEMOS_PATH="$(PKGDIR)/apps/utils/freertos_variscite/boards/$$BOARD_SEL" && \
			DIR_GCC=$$DEMOS_PATH/$$CM_DEMO/armgcc; \
			cd $$DIR_GCC && \
				./clean.sh && \
			if [ `grep -q "make -j" build_all.sh` ]; then \
						sed -i "s/make -j.*[0-9]*/make 28/g" build_all.sh; \
				fi && \
			LDFLAGS="" CFLAGS="" CXXFLAGS="" ./build_all.sh > /dev/null; \
		done ; \
	done && \
	RPROC_DIR="$(PKGDIR)/meta_variscite_bsp_imx/recipes-bsp/freertos-variscite/freertos-variscite" && \
	install -d $(DESTDIR)/etc/remoteproc && \
	install -m 0755 $$RPROC_DIR/variscite-rproc-u-boot $(DESTDIR)/etc/remoteproc && \
	install -m 0755 $$RPROC_DIR/variscite-rproc-linux $(DESTDIR)/etc/remoteproc	&& \
	install -m 0644 $$RPROC_DIR/variscite-rproc-common.sh $(DESTDIR)/etc/remoteproc && \
	install -m 0644 $$RPROC_DIR/$$MACHINE/variscite-rproc.conf $(DESTDIR)/etc/remoteproc && \
	install -d $(DESTDIR)/usr/lib/firmware/ && \
	install -d $(DESTDIR)/boot/ && \
	for CM_DEMO in $(DEMO_LIST); do \
		for BOARD_SEL in $(CM_BOARD); do \
			if [ $(MACHINE) = imx8mp-var-dart ]; then \
				if [ $$BOARD_SEL = dart_mx8mp ]; then \
					CM_FW_SUFFIX="_dart"; \
				elif [ $$BOARD_SEL = som_mx8mp ]; then \
					CM_FW_SUFFIX="_som"; \
				else \
					CM_FW_SUFFIX=""; \
				fi; \
			else \
					CM_FW_SUFFIX=""; \
			fi && \
			DEMOS_PATH="$(PKGDIR)/apps/utils/freertos_variscite/boards/$$BOARD_SEL" && \
			DIR_GCC=$$DEMOS_PATH/$$CM_DEMO/armgcc && \
			for CM_BUILD_TARGET in $(CM_BUILD_TARGETS); do \
				FW_BASENAME=`basename $$DIR_GCC/$$CM_BUILD_TARGET/*.elf .elf` && \
				FILE_CM_FW="$$FW_BASENAME.elf" && \
				install -m 644 $$DIR_GCC/$$CM_BUILD_TARGET/$$FILE_CM_FW $(DESTDIR)/usr/lib/firmware/cm_$$FILE_CM_FW.$$CM_BUILD_TARGET$$CM_FW_SUFFIX && \
				FILE_CM_FW=`basename $$DIR_GCC/$$CM_BUILD_TARGET/*.bin` && \
				install -m 644 $$DIR_GCC/$$CM_BUILD_TARGET/$$FILE_CM_FW $(DESTDIR)/boot/cm_$$FILE_CM_FW.$$CM_BUILD_TARGET$$CM_FW_SUFFIX; \
			done; \
		done; \
	done && \
	$(call fbprint_d,"freertos_variscite")
