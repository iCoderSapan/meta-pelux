#
#   Copyright (C) 2017 Pelagicore AB
#   SPDX-License-Identifier: MIT
#

inherit core-image

# Include softwarecontainer only if the process-containment feature has been enabled
IMAGE_INSTALL += "\
    ${@bb.utils.contains("DISTRO_FEATURES", "process-containment", "softwarecontainer", "", d)} \
"

# GENIVI components
IMAGE_INSTALL += " dlt-daemon         \
                   dlt-daemon-systemd \
                   node-state-manager \
                 "

IMAGE_FEATURES += "ssh-server-openssh package-management"

# Include bluetooth if the machine supports it (MACHINE_FEATURES), and it has
# been selected in DISTRO_FEATURES.
IMAGE_INSTALL += "\
    ${@bb.utils.contains("COMBINED_FEATURES", "bluetooth", "packagegroup-tools-bluetooth", "", d)} \
"

TOOLCHAIN_HOST_TASK += "nativesdk-cmake"

# Add "/usr/lib/cmake" to the PATH variable so that CMake can find the *Config.cmake" when FIND_PACKAGE() is called from a CMake makefile
toolchain_create_sdk_env_script_append() {
	echo 'export PATH=$PATH:$SDKTARGETSYSROOT/usr/lib/cmake' >> $script
}

IMAGE_ROOTFS_SIZE ?= "1000000"
IMAGE_FSTYPES ?= "ext3 sdcard"
