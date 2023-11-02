#
# Copyright (C) 2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := $(call my-dir)

ifneq ($(filter karnak, $(TARGET_DEVICE)),)
include $(call all-makefiles-under,$(LOCAL_PATH))

NVDATA_SYMLINK := $(TARGET_OUT_VENDOR)/nvdata
$(NVDATA_SYMLINK): $(LOCAL_INSTALLED_MODULE)
	@echo "nvdata link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /data/vendor/nvram $@

endif
