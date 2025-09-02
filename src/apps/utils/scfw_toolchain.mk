SCFW_SUPPORT ?= true

scfw_toolchain:
	@[ $(SCFW_SUPPORT) = false ] && exit || \
	$(call fbprint_b,"scfw_toolchain") && \
	set -x && \
	if [ ! -d $(PKGDIR)/apps/utils/scfw_toolchain ]; then \
		mkdir -p $(PKGDIR)/apps/utils/scfw_toolchain; \
	fi && \
	cd $(PKGDIR)/apps/utils/scfw_toolchain && \
	if [ ! -f gcc-arm-none-eabi-8-2018-q4-major-linux.tar.bz ]; then \
		wget https://developer.arm.com/-/media/Files/downloads/gnu-rm/8-2018q4/gcc-arm-none-eabi-8-2018-q4-major-linux.tar.bz && \
		tar -xf gcc-arm-none-eabi-8-2018-q4-major-linux.tar.bz; \
	fi && \
	$(call fbprint_d,"scfw_toolchain")
