set(CPACK_GENERATOR "DEB")
set(CPACK_DEBIAN_PACKAGE_DESCRIPTION "Machinekit hal")
set(CPACK_DEBIAN_PACKAGE_HOMEPAGE "http://machinekit.io")
set(CPACK_DEBIAN_PACKAGE_SHLIBDEPS "ON")
set(CPACK_DEBIAN_PACKAGE_MAINTAINER "GP Orcullo")
set(CPACK_PACKAGE_NAME "machinekit-hal")
set(CPACK_PACKAGE_VERSION "1.0")
set(CPACK_PACKAGE_VERSION_MAJOR ${MK_VERSION_MAJOR})
set(CPACK_PACKAGE_VERSION_MINOR ${MK_VERSION_MINOR})
set(CPACK_PACKAGE_VERSION_PATCH "1234")

configure_file("${CMAKE_SOURCE_DIR}/debian/postinst.in"
    "${CMAKE_BINARY_DIR}/postinst" @ONLY)
set(CPACK_DEBIAN_PACKAGE_CONTROL_EXTRA "${CMAKE_BINARY_DIR}/postinst")

string(TOLOWER "${CPACK_PACKAGE_NAME}" pkg_name)
find_program(LSB lsb_release)
if(LSB)
    execute_process(COMMAND ${LSB} -s -c OUTPUT_VARIABLE codename
        OUTPUT_STRIP_TRAILING_WHITESPACE)
else()
    unset(codename)
endif()

find_program(DPKG dpkg)
if(DPKG)
    execute_process(COMMAND ${DPKG} --print-architecture OUTPUT_VARIABLE arch
        OUTPUT_STRIP_TRAILING_WHITESPACE)
else() 
    set(arch ${CMAKE_SYSTEM_NAME})
endif() 
set(CPACK_PACKAGE_FILE_NAME
    "${pkg_name}_${PACKAGE_VERSION}.${CPACK_PACKAGE_VERSION_PATCH}-${GIT_BRANCH}${GIT_CONFIG_SHA}~1${codename}_${arch}")

include(CPack)
