cmake_minimum_required(VERSION 2.8)

project(Machinekit)
set(MK_VERSION_MAJOR 1)
set(MK_VERSION_MINOR 0)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/modules")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/lib)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/bin)

set(CMAKE_INSTALL_PREFIX /usr)
set(CPACK_PACKAGING_INSTALL_PREFIX ${CMAKE_INSTALL_PREFIX})

set(PROJECT_PYTHON_DIR ${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/python)
set(PROJECT_LIBEXEC_DIR ${PROJECT_BINARY_DIR}/lib/machinekit)
set(PROJECT_LIB_DIR ${PROJECT_BINARY_DIR}/lib)
set(PROJECT_SYSCONF_DIR ${PROJECT_BINARY_DIR}/etc)
set(PROJECT_BIN_DIR ${PROJECT_BINARY_DIR}/bin)
set(PROJECT_DATA_DIR ${PROJECT_BINARY_DIR}/share)
set(PROJECT_LOCALE_DIR ${PROJECT_DATA_DIR}/locale)
set(PROJECT_MAN_DIR ${PROJECT_BINARY_DIR}/man)
set(PROTO_GEN_DIR ${PROJECT_BINARY_DIR}/generated)
set(INCLUDE_DIR ${PROJECT_BINARY_DIR}/include)
set(INSTALL_PYSHARED_DIR ${CMAKE_INSTALL_PREFIX}/share/pyshared)
set(SCRIPTS_DIR ${CMAKE_SOURCE_DIR}/scripts)

if("${CMAKE_INSTALL_PREFIX}" STREQUAL "/usr")
    set(INSTALL_SYSCONF_DIR "/etc")
else()
    set(INSTALL_SYSCONF_DIR "${CMAKE_INSTALL_PREFIX}/etc")
endif()

include(Dependencies)
include(Options)
include(Macros)

include_directories(include)
include_directories(include/nanopb)

add_subdirectory(src)
add_subdirectory(scripts)

## copy over headers and sources for use in recompilation of components

file(GLOB headers
         RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
         "${CMAKE_CURRENT_SOURCE_DIR}/include/*.h"
         "${CMAKE_CURRENT_SOURCE_DIR}/include/*.hh" )

file(GLOB pb_headers
         RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
         "${CMAKE_CURRENT_SOURCE_DIR}/include/nanopb/*.h")
         
file(GLOB pci_headers
         RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
         "${CMAKE_CURRENT_SOURCE_DIR}/include/userpci/*.h")
         
file(MAKE_DIRECTORY "${PROJECT_BINARY_DIR}/include/nanopb")
file(MAKE_DIRECTORY "${PROJECT_BINARY_DIR}/include/userpci")

foreach( filename ${headers})
	file( COPY ${filename} DESTINATION "${PROJECT_BINARY_DIR}/include" )
endforeach()

foreach( filename ${pb_headers})
	file( COPY ${filename} DESTINATION "${PROJECT_BINARY_DIR}/include/nanopb")
endforeach()

foreach( filename ${pci_headers})
	file( COPY ${filename} DESTINATION "${PROJECT_BINARY_DIR}/include/userpci" )
endforeach()

file(GLOB icomps
         RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
         "${CMAKE_CURRENT_SOURCE_DIR}/src/hal/i_components/*.icomp")

foreach( filename ${icomps})
	file( COPY ${filename} DESTINATION "${PROJECT_BINARY_DIR}/src/hal/i_components" )
endforeach()
