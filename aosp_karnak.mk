#
# Copyright (C) 2019 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_p.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)

# Inherit from device makefile.
$(call inherit-product, device/amazon/karnak/device.mk)

# Inherit from standard AOSP bases
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/handheld_product.mk)

# Inherit GApps
$(call inherit-product-if-exists, vendor/vendor_gms/gms_full_tablet_wifionly.mk)

# Android Go optimisations
$(call inherit-product, device/amazon/karnak/go_opt.mk)

# Dalvik
$(call inherit-product, frameworks/native/build/phone-xhdpi-1024-dalvik-heap.mk)

PRODUCT_NAME := aosp_karnak
PRODUCT_DEVICE := karnak
PRODUCT_MANUFACTURER := amzn
PRODUCT_BRAND := google
PRODUCT_MODEL := Fire

BUILD_FINGERPRINT := google/tangorpro/tangorpro:14/UP1A.231005.007/10754064:user/release-keys

TARGET_SCREEN_WIDTH := 1280
TARGET_SCREEN_HEIGHT := 800
