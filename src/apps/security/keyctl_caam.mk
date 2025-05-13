# Copyright 2017-2023 NXP
#
# SPDX-License-Identifier: BSD-3-Clause


keyctl_caam:
ifeq ($(strip $(subst ",,$(CONFIG_OPENSSL))),y)
	@[ $(DISTROVARIANT) = base -o $(DISTROVARIANT) = tiny ] && exit || \
	 $(call fbprint_b,"keyctl_caam") && \
	 $(call repo-mngr,fetch,keyctl_caam,apps/security) && \
	 if [ ! -d $(DESTDIR)/usr/include/openssl ]; then \
		bld openssl -r $(DISTROTYPE):$(DISTROVARIANT) -a $(DESTARCH); \
	 fi && \
	 cd $(SECDIR)/keyctl_caam && \
	 export OPENSSL_PATH=$(SECDIR)/openssl && \
	 $(MAKE) CC=$(CROSS_COMPILE)gcc DESTDIR=$(DESTDIR) install && \
	 $(call fbprint_d,"keyctl_caam")
endif
