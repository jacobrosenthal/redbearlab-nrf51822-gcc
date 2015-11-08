# Copyright (c) 2015 ARM Limited
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

if(TARGET_REDBEARLAB_NRF51822_GCC_TOOLCHAIN_INCLUDED)
    return()
endif()
set(TARGET_REDBEARLAB_NRF51822_GCC_TOOLCHAIN_INCLUDED 1)

set(NRF51822_GEN_DAT_SCRIPT "${CMAKE_CURRENT_LIST_DIR}/../scripts/generate_dat.py")

# define a function for yotta to apply target-specific rules to build products,
# in our case we need to convert the built elf file to .hex, and add the
# pre-built softdevice:
function(yotta_apply_target_rules target_type target_name)
    if(${target_type} STREQUAL "EXECUTABLE")
        add_custom_command(TARGET ${target_name}
            POST_BUILD
            # objcopy to bin
            COMMAND arm-none-eabi-objcopy -O binary ${target_name} ${target_name}.bin
            # generate dfu .dat from bin
            COMMAND python ${NRF51822_GEN_DAT_SCRIPT} ${target_name}.bin
            VERBATIM
        )
    endif()
endfunction()
