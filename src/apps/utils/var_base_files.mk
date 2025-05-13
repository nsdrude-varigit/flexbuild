# Copyright 2021-2025 Variscite
#
# SPDX-License-Identifier: BSD-3-Clause


# Variscite Base Files

var_base_files:
	@[ $(SOCFAMILY) != IMX -o $(DISTROVARIANT) = base -o $(DISTROVARIANT) = tiny ] && exit || \
	$(call fbprint_b,"var_base_files") && \
	$(call repo-mngr,fetch,meta_variscite_sdk_common) && \
	mkdir -p $(PKGDIR)/apps/utils/var_base_files && \
	cd $(PKGDIR)/apps/utils/var_base_files && \
	install -d $(DESTDIR)/etc && \
	install -m 0755 $(PKGDIR)/meta_variscite_sdk_common/recipes-core/base-files/base-files/issue $(DESTDIR)/etc && \
	install -m 0755 $(PKGDIR)/meta_variscite_sdk_common/recipes-core/base-files/base-files/issue.net $(DESTDIR)/etc/issue.net && \
	$(call fbprint_d,"var_base_files") \
