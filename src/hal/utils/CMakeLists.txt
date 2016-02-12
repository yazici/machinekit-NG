set(HALCMD_SRCS 
    halcmd.c
    halcmd_commands.c
    halcmd_main.c
    halcmd_rtapiapp.cc 
    halcmd_completion.c)

add_library(halcmd_rtapiapp OBJECT halcmd_rtapiapp.cc)

add_executable(halcmd ${HALCMD_SRCS})
target_link_libraries(halcmd mkini mkhal mk-pb2++ mtalk rtapi_math readline)

add_executable(pci_write pci_write.c upci.c)
add_executable(pci_read pci_read.c upci.c)

foreach(util comp instcomp)
    set(src ${CMAKE_CURRENT_SOURCE_DIR}/${util}.g)
    add_custom_command( 
        OUTPUT ${util}.py
        COMMAND ${YAPPS} ${src} ${util}.py
        DEPENDS ${src}
        COMMENT "Creating ${util}.py")
    add_python_target(${util} ${PROJECT_BIN_DIR} "" 
        ${CMAKE_CURRENT_BINARY_DIR} ${util})
endforeach()

add_executable(halmeter meter.c miscgtk.c)
set_property(TARGET halmeter APPEND PROPERTY 
    INCLUDE_DIRECTORIES "${GTK2_INCLUDE_DIRS}")
target_link_libraries(halmeter mkhal ${GTK2_LIBRARIES})

set(HALSCOPE_SRCS
    scope.c
    scope_horiz.c
    scope_vert.c
    scope_trig.c
    scope_disp.c
    scope_files.c
    miscgtk.c)

add_executable(halscope ${HALSCOPE_SRCS})
set_property(TARGET halscope APPEND PROPERTY
    INCLUDE_DIRECTORIES "${GTK2_INCLUDE_DIRS}")
target_link_libraries(halscope mkhal rtapi_math ${GTK2_LIBRARIES})

_to_rtlib(scope_rt scope_rt.c)
_install_exec(scope_rt)

# fixme
# set_property(GLOBAL APPEND PROPERTY target-dev pyhal_utils)
set(target halcmd pci_write pci_read halmeter halscope)
_install("${target}")
