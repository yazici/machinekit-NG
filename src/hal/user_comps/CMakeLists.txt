add_definitions(-DULAPI)
if(HAVE_LIBMODBUS)
    add_subdirectory(vfs11_vfd)
    add_subdirectory(vfdb_vfd)
    add_subdirectory(mb2hal)
endif()

set(USER_COMP_PY
    gladevcp
	hal_storage)

add_python_target(user_comp ${PROJECT_BIN_DIR} "" 
    ${CMAKE_CURRENT_SOURCE_DIR} ${USER_COMP_PY})
add_custom_target(_user_comp ALL DEPENDS user_comp)
foreach(file ${USER_COMP_PY})
    _install_script(${PROJECT_BIN_DIR}/${file})
endforeach()

if(HAVE_LIBMODBUS)
    add_executable(gs2_vfd gs2_vfd.c)
    set_target_properties(gs2_vfd PROPERTIES COMPILE_FLAGS "${LIBMODBUS_CFLAGS}")
    target_link_libraries(gs2_vfd mkhal ${LIBMODBUS_LIBRARIES})
    _install(gs2_vfd)
endif()

if(HAVE_LIBUSB)
    add_executable(xhc-hb04 xhc-hb04.cc)
    set_target_properties(xhc-hb04 PROPERTIES COMPILE_FLAGS "${LIBUSB_CFLAGS}")
    target_link_libraries(xhc-hb04 mkhal mkini rtapi_math ${LIBUSB_LIBRARIES})
    _install(xhc-hb04)
endif()

if(HIDRAW_H_USABLE)
    add_executable(shuttlexpress shuttlexpress.c)
    target_link_libraries(shuttlexpress mkhal)
    _install(shuttlexpress)
endif()
