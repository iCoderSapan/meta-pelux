#
#   Copyright (C) 2017 Pelagicore AB
#   SPDX-License-Identifier: MIT
#

DESCRIPTION = "Reference PELUX image with QtAuto frontend"

inherit core-image-pelux-qtauto

# This image uses neptune as the reference UI
IMAGE_INSTALL += " neptune-ui "
