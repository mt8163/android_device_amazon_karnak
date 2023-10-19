#
# Copyright (C) 2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_p.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)

# Inherit from device makefile.
$(call inherit-product, device/amazon/karnak/device.mk)

# Inherit some common LineageOS stuff.
$(call inherit-product, vendor/lineage/config/common_full_tablet_wifionly.mk)

# Inherit GApps
$(call inherit-product-if-exists, vendor/vendor_gms/gms_full_tablet_wifionly.mk)

# Android Go optimisations
$(call inherit-product, device/amazon/karnak/go_opt.mk)

PRODUCT_NAME := lineage_karnak
PRODUCT_DEVICE := karnak
PRODUCT_MANUFACTURER := amzn
PRODUCT_BRAND := google
PRODUCT_MODEL := Fire

BUILD_FINGERPRINT := google/tangorpro/tangorpro:14/UP1A.231005.007/10754064:user/release-keys
