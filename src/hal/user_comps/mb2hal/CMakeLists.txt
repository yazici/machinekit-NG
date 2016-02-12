set(MB2HAL_SRCS
    mb2hal.c
    mb2hal_init.c
    mb2hal_modbus.c
    mb2hal_hal.c)

add_executable(mb2hal ${MB2HAL_SRCS})
set_target_properties(mb2hal PROPERTIES COMPILE_FLAGS "${LIBMODBUS_CFLAGS}")
target_link_libraries(mb2hal mkhal mkini rtapi_math ${LIBMODBUS_LIBRARIES})
_install(mb2hal)
