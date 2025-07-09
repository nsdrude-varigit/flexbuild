CM_GCC ?= "12.3.rel1"

cortexm_toolchain_cross:
	$(call fbprint_b,"cortexm_toolchain_cross") && \
	set -x && \
	if [ ! -d $(PKGDIR)/apps/utils/cortexm_toolchain_cross ]; then \
		mkdir -p $(PKGDIR)/apps/utils/cortexm_toolchain_cross; \
	fi && \
	cd $(PKGDIR)/apps/utils/cortexm_toolchain_cross && \
	if [ ! -f arm-gnu-toolchain-${CM_GCC}-x86_64-arm-none-eabi.tar.xz ]; then \
		wget https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu/${CM_GCC}/binrel/arm-gnu-toolchain-${CM_GCC}-x86_64-arm-none-eabi.tar.xz && \
		tar -xf arm-gnu-toolchain-${CM_GCC}-x86_64-arm-none-eabi.tar.xz --strip-components=1; \
	fi && \
	$(call fbprint_d,"cortexm_toolchain_cross")
