add_subdirectory(machinekit)

set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_PYTHON_DIR}/machinekit)

# fix rpath to enable RIP on build dir
SET(CMAKE_SKIP_BUILD_RPATH  FALSE)
SET(CMAKE_BUILD_WITH_INSTALL_RPATH FALSE) 
SET(CMAKE_INSTALL_RPATH "${_rpath}")
SET(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)

set(PWD ${CMAKE_CURRENT_BINARY_DIR}/machinekit)

add_library(cy_hal SHARED $<TARGET_OBJECTS:hal_obj>
    $<TARGET_OBJECTS:halcmd_rtapiapp>)
target_link_libraries(cy_hal mkhal mtalk mk_rip)
set_target_properties(cy_hal PROPERTIES
    OUTPUT_NAME "hal"
    PREFIX "")

add_library(cy_rtapi SHARED $<TARGET_OBJECTS:rtapi_obj>
    $<TARGET_OBJECTS:halcmd_rtapiapp>)
target_link_libraries(cy_rtapi mkhal mtalk mk-pb2++ mk_rip)
set_target_properties(cy_rtapi PROPERTIES
    OUTPUT_NAME "rtapi"
    PREFIX "")

add_library(cy_compat SHARED $<TARGET_OBJECTS:compat_obj>)
target_link_libraries(cy_compat mkhal mk_rip)
set_target_properties(cy_compat PROPERTIES
    OUTPUT_NAME "compat"
    PREFIX "")

add_library(cy_shmcommon SHARED $<TARGET_OBJECTS:shmcommon_obj>
    $<TARGET_OBJECTS:shmdrvapi>)
target_link_libraries(cy_shmcommon mk_rip)
set_target_properties(cy_shmcommon PROPERTIES
    OUTPUT_NAME "shmcommon"
    PREFIX "")

# copy all *.so on a separate directory so that the linker can strip the RPATH
set(_dir ${PROJECT_PYTHON_DIR}/machinekit)
set(_CMD ${CMAKE_COMMAND} -E copy_directory ${_dir} ${PROJECT_DIST_DIR}/machinekit)
install(CODE "execute_process(COMMAND ${_CMD})")
install(TARGETS cy_hal cy_rtapi cy_compat cy_shmcommon
    DESTINATION ${PROJECT_DIST_DIR}/machinekit)
_install_py()
