#
# Copyright (C) 2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/amazon/karnak

# Architecture
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_VARIANT := cortex-a53
TARGET_CPU_VARIANT_RUNTIME := cortex-a53

TARGET_USES_64_BIT_BINDER := true

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := karnak
TARGET_NO_BOOTLOADER := true

# Boot Image
BOARD_BOOTIMG_HEADER_VERSION := 1
BOARD_RAMDISK_USE_XZ := true
BOARD_KERNEL_BASE         := 0x40080000
BOARD_KERNEL_PAGESIZE     := 2048
BOARD_KERNEL_OFFSET       := 0x00000000
BOARD_RAMDISK_OFFSET      := 0x03400000
BOARD_KERNEL_TAGS_OFFSET  := 0x07f80000
BOARD_SECOND_OFFSET       := 0x00e80000
BOARD_MKBOOTIMG_ARGS := \
    --kernel_offset $(BOARD_KERNEL_OFFSET) \
    --ramdisk_offset $(BOARD_RAMDISK_OFFSET) \
    --second_offset $(BOARD_SECOND_OFFSET)   \
    --tags_offset $(BOARD_KERNEL_TAGS_OFFSET) \
    --header_version $(BOARD_BOOTIMG_HEADER_VERSION)

BOARD_KERNEL_CMDLINE := bootopt=64S3,32N2,64N2
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive
BOARD_KERNEL_CMDLINE += androidboot.init_fatal_reboot_target=recovery

# Kernel
BOARD_KERNEL_IMAGE_NAME := Image.gz-dtb
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_SOURCE := kernel/amazon/karnak
TARGET_KERNEL_CONFIG := lineageos_karnak_defconfig
TARGET_KERNEL_CROSS_COMPILE_PREFIX := $(shell pwd)/prebuilts/linaro/linux-x86/aarch64/aarch64-linux-gnu/bin/aarch64-linux-gnu-
TARGET_KERNEL_LLVM_BINUTILS := false

# Platform
TARGET_BOARD_PLATFORM := mt8163

# Inherit the proprietary files
include vendor/amazon/karnak/BoardConfigVendor.mk
