#!/usr/bin/env -S PYTHONPATH=../../../tools/extract-utils python3
#
# SPDX-FileCopyrightText: 2024 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

from extract_utils.file import File
from extract_utils.fixups_blob import (
    blob_fixup,
    blob_fixups_user_type,
)
from extract_utils.fixups_lib import (
    lib_fixups,
)
from extract_utils.main import (
    ExtractUtils,
    ExtractUtilsModule,
)

namespace_imports = [
    'device/amazon/karnak',
    'hardware/amazon',
    'vendor/amazon/karnak',
    'vendor/amazon/mt8163'
]

blob_fixups: blob_fixups_user_type = {
    'vendor/lib/libnvram.so': blob_fixup()
        .add_needed('libshim_nvram.so'),
    'vendor/lib/hw/keystore.mt8163.so': blob_fixup()
        .add_needed('libshim_keymaster.so')
        .replace_needed('libkeymaster_messages.so', 'libkeymaster_messages-v28.so'),
    'vendor/lib/libmtkcam_stdutils.so': blob_fixup()
        .add_needed('libshim_mtkcam.so')
        .replace_needed('libutils.so', 'libutils-v30.so'),
    'vendor/lib/libcam.client.so': blob_fixup()
        .add_needed('libshim_gui.so'),
    'vendor/lib/libMtkOmxVdecEx.so': blob_fixup()
        .add_needed('libshim_gui.so'),
    'vendor/lib/hw/fireos.hardware.audio@4.0-impl.so': blob_fixup()
        .replace_needed('android.hardware.audio.common@4.0-util.so', 'android.hardware.audio.common@4.0-util_v28.so'),
    'vendor/lib/libwvhidl.so': blob_fixup()
        .replace_needed('libprotobuf-cpp-lite.so', 'libprotobuf-cpp-lite-v28.so'),
    'vendor/lib/mediadrm/libwvdrmengine.so' : blob_fixup()
        .replace_needed('libprotobuf-cpp-lite.so', 'libprotobuf-cpp-lite-v28.so'),
    'vendor/lib/vendor/bin/amzn_drmprov_check': blob_fixup()
        .add_needed('libamazonlog.so'),
    'vendor/lib/hw/audio.btle.default.so': blob_fixup()
        .add_needed('libamazonlog.so'),
    'vendor/lib/libmtk_drvb.so': blob_fixup()
        .binary_regex_replace(
            b'\x99@\x1a\x02\xd1 F\x02\xb0\x10\xbd\x02\xf0',
            b'\x99@\x1a\x02\xd1\x00 \x02\xb0\x10\xbd\x02\xf0',
        ),
    'vendor/etc/init/fireos.hardware.amazonthermal@1.0-service.rc': blob_fixup()
        .binary_regex_replace(
            br'/\*\x0a \* Copyright \(c\) 2019 Amazon\.com, Inc\. or its affiliates\.  All rights reserved\.\x0a \*\x0a \* PROPRIETARY/CONFIDENTIAL\.  USE IS SUBJECT TO LICENSE TERMS\.\x0a \*/\x0a\x0a',
            b'',
        ),
    'vendor/etc/init/fireos.hardware.connectivity.networkpower@1.0-service.rc': blob_fixup()
        .binary_regex_replace(
            br'/\*\x0a \* Copyright \(c\) \d{4} Amazon\.com, Inc\. or its affiliates\.  All rights reserved\.\x0a \*\x0a \* PROPRIETARY/CONFIDENTIAL\.  USE IS SUBJECT TO LICENSE TERMS\.\x0a \*/\x0a\x0a',
            b'',
        ),
    'vendor/etc/init/vendor.mediatek.hardware.keymaster_attestation@1.1-service.rc': blob_fixup()
        .binary_regex_replace(
            br'(interface\s+vendor\.mediatek\.hardware\.keymaster_attestation@1\.1::IKeymasterDevice\s+default)',
            br'# \1',
        ),
}  # fmt: skip

module = ExtractUtilsModule(
    'karnak',
    'amazon',
    blob_fixups=blob_fixups,
    lib_fixups=lib_fixups,
    namespace_imports=namespace_imports,
)

if __name__ == '__main__':
    utils = ExtractUtils.device(module)
    utils.run()
