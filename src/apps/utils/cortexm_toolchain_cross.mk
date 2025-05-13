cortexm_toolchain_cross:
	$(call fbprint_b,"cortexm_toolchain_cross") && \
	set -x && \
	if [ ! -d $(PKGDIR)/apps/utils/cortexm_toolchain_cross ]; then \
		mkdir -p $(PKGDIR)/apps/utils/cortexm_toolchain_cross; \
	fi && \
	cd $(PKGDIR)/apps/utils/cortexm_toolchain_cross && \
	if [ ! -f arm-gnu-toolchain-12.3.rel1-x86_64-arm-none-eabi.tar.xz ]; then \
		wget https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu/12.3.rel1/binrel/arm-gnu-toolchain-12.3.rel1-x86_64-arm-none-eabi.tar.xz && \
		tar -xf arm-gnu-toolchain-12.3.rel1-x86_64-arm-none-eabi.tar.xz --strip-components=1; \
	fi && \
	$(call fbprint_d,"cortexm_toolchain_cross")
