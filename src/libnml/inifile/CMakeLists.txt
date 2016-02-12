add_library(inifile OBJECT inifile.cc)

add_library(mkini SHARED $<TARGET_OBJECTS:inifile>)
set_target_properties(mkini PROPERTIES VERSION ${GENERIC_LIB_VERSION})
_install(mkini)

add_executable(inivar inivar.cc)
set_target_properties(inivar PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY ${PROJECT_LIBEXEC_DIR})
target_link_libraries(inivar mkini)
_install_exec(inivar)
