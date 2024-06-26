#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

DEVICE=karnak
VENDOR=amazon

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}/../../.."

HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

# Default to sanitizing the vendor folder before extraction
CLEAN_VENDOR=true

KANG=
SECTION=

while [ "${#}" -gt 0 ]; do
    case "${1}" in
        -n | --no-cleanup )
                CLEAN_VENDOR=false
                ;;
        -k | --kang )
                KANG="--kang"
                ;;
        -s | --section )
                SECTION="${2}"; shift
                CLEAN_VENDOR=false
                ;;
        * )
                SRC="${1}"
                ;;
    esac
    shift
done

if [ -z "${SRC}" ]; then
    SRC="adb"
fi

function blob_fixup() {
    case "$1" in
        vendor/lib/libnvram.so)
            "${PATCHELF}" --add-needed "libshim_nvram.so" "${2}"
            ;;
        vendor/lib/hw/keystore.mt8163.so)
            "${PATCHELF}" --add-needed "libshim_keymaster.so" "${2}"
            "${PATCHELF}" --replace-needed "libkeymaster_messages.so" "libkeymaster_messages-v28.so" "${2}"
            ;;
        vendor/lib/libmtkcam_stdutils.so)
            "${PATCHELF}" --add-needed "libshim_mtkcam.so" "${2}"
            "${PATCHELF}" --replace-needed "libutils.so" "libutils-v30.so" "${2}"
            ;;
        vendor/lib/libcam.client.so)
            "${PATCHELF}" --add-needed "libshim_gui.so" "${2}"
            ;;
        vendor/lib/libMtkOmxVdecEx.so)
            "${PATCHELF}" --add-needed "libshim_gui.so" "${2}"
            ;;
        vendor/lib/hw/fireos.hardware.audio@4.0-impl.so)
            "${PATCHELF}" --replace-needed "android.hardware.audio.common@4.0-util.so" "android.hardware.audio.common@4.0-util_v28.so" "${2}"
            ;;
        vendor/lib/libwvhidl.so)
            "${PATCHELF}" --replace-needed "libprotobuf-cpp-lite.so" "libprotobuf-cpp-lite-v28.so" "${2}"
            ;;
        vendor/lib/mediadrm/libwvdrmengine.so)
            "${PATCHELF}" --replace-needed "libprotobuf-cpp-lite.so" "libprotobuf-cpp-lite-v28.so" "${2}"
            ;;
        vendor/lib/vendor/bin/amzn_drmprov_check)
            "${PATCHELF}" --add-needed "libamazonlog.so" "${2}"
            ;;
        vendor/lib/hw/audio.btle.default.so)
            "${PATCHELF}" --add-needed "libamazonlog.so" "${2}"
            ;;
        vendor/lib/libmtk_drvb.so)
            sed -i 's|\x99@\x1a\x02\xd1 F\x02\xb0\x10\xbd\x02\xf0|\x99@\x1a\x02\xd1\x00 \x02\xb0\x10\xbd\x02\xf0|g' "${2}"
            ;;
    esac
}

# Initialize the helper
setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}" false "${CLEAN_VENDOR}"

extract "${MY_DIR}/proprietary-files.txt" "${SRC}" "${KANG}" --section "${SECTION}"

"${MY_DIR}/setup-makefiles.sh"
