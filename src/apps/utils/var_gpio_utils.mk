# Copyright 2021-2025 Variscite
#
# SPDX-License-Identifier: BSD-3-Clause


# Variscite WiFi + Bluetooth


var_gpio_utils:
	@[ $(SOCFAMILY) != IMX -o $(DISTROVARIANT) = base -o $(DISTROVARIANT) = tiny ] && exit || \
	$(call fbprint_b,"var_gpio_utils") && \
	$(call repo-mngr,fetch,meta_variscite_bsp_common) && \
	GPIOCHIP_DIR="$(PKGDIR)/meta_variscite_bsp_common/recipes-support/var-gpio-utils/var-gpio-utils" && \
	install -d $(DESTDIR)/etc && \
	install -m 0755 $$GPIOCHIP_DIR/gpiochip $(DESTDIR)/etc && \
	$(call fbprint_d,"var_gpio_utils") \
