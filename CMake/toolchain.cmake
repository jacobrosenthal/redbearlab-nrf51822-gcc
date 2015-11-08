
if(TARGET_REDBEARLAB_NRF51822_GCC_TOOLCHAIN_INCLUDED)
    return()
endif()
set(TARGET_REDBEARLAB_NRF51822_GCC_TOOLCHAIN_INCLUDED 1)

set(NRF51822_GEN_DAT_SCRIPT "${CMAKE_CURRENT_LIST_DIR}/../scripts/generate_dat.py")

# define a function for yotta to apply target-specific rules to build products,
# in our case we need to convert the built elf file to .bin, and generate the dfu .dat
function(yotta_apply_target_rules target_type target_name)
    if(${target_type} STREQUAL "EXECUTABLE")
        add_custom_command(TARGET ${target_name}
            POST_BUILD
            COMMAND "${ARM_NONE_EABI_OBJCOPY}" -O binary ${target_name} ${target_name}.bin
            COMMENT "converting to .bin"
            # generate dfu .dat from bin
            COMMAND python ${NRF51822_GEN_DAT_SCRIPT} ${target_name}.bin
            COMMENT "generating .dat"
            VERBATIM
        )
    endif()
endfunction()
