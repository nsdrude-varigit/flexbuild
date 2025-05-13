# Copyright (C) 2025 Variscite

PM_ETH_SUSPEND_MODE ?= disabled

var_pm_utils:
	@[ $(SOCFAMILY) != IMX -o $(DISTROVARIANT) = base -o $(DISTROVARIANT) = tiny ] && exit || \
	$(call fbprint_b,"var_pm_utils") && \
	$(call repo-mngr,fetch,meta_variscite_bsp_imx) && \
	VAR_PM_UTILS_DIR="$(PKGDIR)/meta_variscite_bsp_imx/recipes-bsp/pm-utils/pm-utils-variscite" && \
	mkdir -p $(PKGDIR)/apps/utils/var_pm_utils && \
	cd $(PKGDIR)/apps/utils/var_pm_utils && \
	install -d $(DESTDIR)/etc/pm/sleep.d && \
	install -m 0755 $$VAR_PM_UTILS_DIR/00-ot.sh $(DESTDIR)/etc/pm/sleep.d && \
	install -m 0755 $$VAR_PM_UTILS_DIR/01-eth.sh $(DESTDIR)/etc/pm/sleep.d && \
	install -m 0755 $$VAR_PM_UTILS_DIR/02-bt.sh $(DESTDIR)/etc/pm/sleep.d && \
	install -m 0755 $$VAR_PM_UTILS_DIR/03-wifi.sh $(DESTDIR)/etc/pm/sleep.d && \
	echo "ETH_SUSPEND_MODE=\"${PM_ETH_SUSPEND_MODE}\"" > $(PKGDIR)/apps/utils/var_pm_utils/var_pm_config && \
	install -m 0644 $(PKGDIR)/apps/utils/var_pm_utils/var_pm_config $(DESTDIR)/etc/pm && \
	$(call fbprint_d,"var_pm_utils")
