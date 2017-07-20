#
# Copyright (C) 2008 The Android Open Source Project
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

# This file is executed by build/envsetup.sh, and can use anything
# defined in envsetup.sh.
#
# In particular, you can add lunch options with the add_lunch_combo
# function: add_lunch_combo generic-eng

function apply_patch()
{
    repo forall -c '$ANDROID_BUILD_TOP/device/softwinner/wing-common/apply_patch.sh'

    echo "If you see errors like unsupported reloc 43 or 42 when compiling host art"
    echo "replace the prebuilt ld with host ld as below to fix the issue:"
    echo "Android L: cp /usr/bin/ld.gold prebuilts/gcc/linux-x86/host/x86_64-linux-glibc2.11-4.6/x86_64-linux/bin/ld"
    echo "Android M: cp /usr/bin/ld.gold prebuilts/gcc/linux-x86/host/x86_64-linux-glibc2.15-4.8/x86_64-linux/bin/ld"
    echo "This kind of issue is seen on Ubuntu 16.04 when compiling host tools, due to incompatible binutils"
}

add_lunch_combo wing_clover-eng
