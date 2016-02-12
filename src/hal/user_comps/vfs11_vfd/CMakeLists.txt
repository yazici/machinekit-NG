add_executable(vfs11_vfd vfs11_vfd.c)
set_target_properties(vfs11_vfd PROPERTIES COMPILE_FLAGS "${LIBMODBUS_CFLAGS}")
target_link_libraries(vfs11_vfd mkhal mkini ${LIBMODBUS_LIBRARIES})
_install(vfs11_vfd)
