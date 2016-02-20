if(WITH_TARGET_PLATFORM_BEAGLEBONE)
    add_library(prussdrv OBJECT prussdrv.c)
    set_target_properties(prussdrv PROPERTIES
        COMPILE_DEFINITIONS "RTAPI;THREAD_FLAVOR_ID=0")
endif()
