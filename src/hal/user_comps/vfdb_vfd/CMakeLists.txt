add_executable(vfdb_vfd vfdb_vfd.c)
set_target_properties(vfdb_vfd PROPERTIES COMPILE_FLAGS "${LIBMODBUS_CFLAGS}")
target_link_libraries(vfdb_vfd mkhal mkini rtapi_math ${LIBMODBUS_LIBRARIES})
_install(vfdb_vfd)
