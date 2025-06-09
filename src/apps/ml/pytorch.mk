# Copyright 2023-2024 NXP
#
# SPDX-License-Identifier: BSD-3-Clause

# Tensors and Dynamic neural networks in Python with strong GPU acceleration

# RDEPENDS: python3-core python3-numpy python3-future python3-typing-extensions numactl

pytorch:
ifeq ($(strip $(subst ",,$(CONFIG_PYTORCH))),y)
	@[ $(DESTARCH) != arm64 -o $(DISTROVARIANT) = tiny -o $(DISTROVARIANT) = base ] && exit || \
	 $(call fbprint_b,"pytorch") && \
	 $(call repo-mngr,fetch,pytorch,apps/ml) && \
	 cd $(MLDIR)/pytorch && \
	 install -d $(DESTDIR)/usr/bin/pytorch/examples && \
	 install -m 0555 examples/pytorch_mobilenetv2.py $(DESTDIR)/usr/bin/pytorch/examples && \
	 $(call fbprint_d,"pytorch")
endif
