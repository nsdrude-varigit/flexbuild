# Copyright 2021-2025 Variscite
#
# SPDX-License-Identifier: BSD-3-Clause

DISTRO = $(DISTRIB_NAME) - $(DISTRIB_VERSION)
DISTRO_VERSION = Debian $(DEBIAN_CODENAME) $(DEBIAN_VERSION)
repo_list = meta_variscite_bsp_imx meta_variscite_bsp_common meta_variscite_sdk_common
config_list_name=`grep -oP '(?<=^repo_).*(?=_url)' $(FBDIR)/configs/.sdk.cfg`

buildinfo:
	@[ $(SOCFAMILY) != IMX -o $(DISTROVARIANT) = base -o $(DISTROVARIANT) = tiny ] && exit || \
	$(call fbprint_b,"buildinfo") && \
	mkdir -p $(PKGDIR)/apps/utils/ && \
	cd $(PKGDIR)/apps/utils/ && \
	echo "-----------------------" > buildinfo && \
	echo "Build Configuration:  |" >> buildinfo && \
	echo "-----------------------" >> buildinfo && \
	echo "DISTRO = $(DISTRO)" >> buildinfo && \
	echo "DISTRO_VERSION = $(DISTRO_VERSION)" >> buildinfo && \
	echo "-----------------------" >> buildinfo && \
	echo "Layer Revisions:      |" >> buildinfo && \
	echo "-----------------------" >> buildinfo && \
	for repo_name in $(config_list_name); do \
		if [ `sudo cat $(FBDIR)/configs/.sdk.cfg | grep -i repo_"$$repo_name"_commit` ]; then \
			repo_ref=`sudo cat $(FBDIR)/configs/.sdk.cfg | grep -i repo_"$$repo_name"_commit | cut -d '=' -f 2- | tr -d '"'`; \
		elif [ `sudo cat $(FBDIR)/configs/.sdk.cfg | grep -i repo_"$$repo_name"_tag` ]; then \
		  repo_ref=`sudo cat $(FBDIR)/configs/.sdk.cfg | grep -i repo_"$$repo_name"_tag | cut -d '=' -f 2- | tr -d '"'`; \
		else \
			repo_ref=$(DEFAULT_REPO_TAG); \
		fi && \
		echo "$$repo_name = $$repo_ref" >> buildinfo; \
	done && \
	echo "DEFAULT_REPO_TAG = $(DEFAULT_REPO_TAG)" && \
	install -d $(DESTDIR)/etc/ && \
	install -m 0755 $(PKGDIR)/apps/utils/buildinfo $(DESTDIR)/etc/buildinfo && \
	$(call fbprint_d,"buildinfo")
