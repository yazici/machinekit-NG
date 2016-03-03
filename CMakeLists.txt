cmake_minimum_required(VERSION 2.8)

project(Machinekit)
set(MK_VERSION_MAJOR 1)
set(MK_VERSION_MINOR 0)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/modules")

## ensure make locally ie. within the repo, even if the provided /build dir is not used
set(PROJECT_BINARY_DIR ${CMAKE_SOURCE_DIR})

set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/lib)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/bin)

MESSAGE(DBG " Before evaluation CMAKE_INSTALL_PREFIX = ${CMAKE_INSTALL_PREFIX}")

if(CMAKE_INSTALL_PREFIX AND EXISTS "${CMAKE_INSTALL_PREFIX}" AND IS_DIRECTORY "${CMAKE_INSTALL_PREFIX}")
    set(RUN_IN_PLACE "no")
    MESSAGE(" Building for installation to ${CMAKE_INSTALL_PREFIX} ")
    if("${CMAKE_INSTALL_PREFIX}" STREQUAL "/usr")
        set(INSTALL_SYSCONF_DIR "/etc")
    else()
        set(INSTALL_SYSCONF_DIR "${CMAKE_INSTALL_PREFIX}/etc")
    endif()
else()
    set(RUN_IN_PLACE "yes")
    set(CMAKE_INSTALL_PREFIX ${PROJECT_BINARY_DIR})
#    MESSAGE("${CMAKE_INSTALL_PREFIX} specified does not exist or is not a directory")
#    endif()
#else()
#    set(CMAKE_INSTALL_PREFIX ${PROJECT_BINARY_DIR})
#    set(RUN_IN_PLACE "yes")
endif()

# we build in the repo tree for everything, then copy elsewhere for install or deb
#set(PROJECT_EMC2_HOME ${CMAKE_SOURCE_DIR})

MESSAGE(DBG " CMAKE_INSTALL_PREFIX = ${CMAKE_INSTALL_PREFIX}")
MESSAGE(DBG " RUN_IN_PLACE = ${RUN_IN_PLACE}")
MESSAGE(DBG " PROJECT_BINARY_DIR = ${PROJECT_BINARY_DIR}")

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


include(Dependencies)
include(Options)
include(Macros)

include_directories(include)
include_directories(include/nanopb)

add_subdirectory(src)
add_subdirectory(scripts)

install(DIRECTORY ${PROJECT_BINARY_DIR}/include/
        DESTINATION ${CMAKE_INSTALL_PREFIX}/include
	FILES_MATCHING PATTERN "*.h" PATTERN "*.hh")
	
install(DIRECTORY ${PROJECT_BINARY_DIR}/include/nanopb/ 
	DESTINATION ${CMAKE_INSTALL_PREFIX}/include/nanopb
	FILES_MATCHING PATTERN "*.h" PATTERN "*.hh")

install(DIRECTORY ${PROJECT_BINARY_DIR}/include/userpci/ 
	DESTINATION ${CMAKE_INSTALL_PREFIX}/include/userpci
	FILES_MATCHING PATTERN "*.h" PATTERN "*.hh")

install(DIRECTORY ${PROJECT_BINARY_DIR}/src/hal/i_components/ 
	DESTINATION ${CMAKE_INSTALL_PREFIX}/share/machinekit/i_components
	FILES_MATCHING PATTERN "*.icomp")
	
install(DIRECTORY ${PROJECT_BINARY_DIR}/src/hal/components/ 
	DESTINATION ${CMAKE_INSTALL_PREFIX}/share/machinekit/components
	FILES_MATCHING PATTERN "*.comp" PATTERN "*.c*")

