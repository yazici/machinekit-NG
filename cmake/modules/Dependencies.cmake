# required packages
find_package(PkgConfig REQUIRED)
pkg_check_modules(PROTOBUF REQUIRED protobuf>=2.4.1)
pkg_check_modules(CZMQ REQUIRED libczmq>=2.2.0)
pkg_check_modules(AVAHI REQUIRED avahi-client)
pkg_check_modules(JANSSON REQUIRED jansson>=2.5)
pkg_check_modules(LWS REQUIRED libwebsockets)
pkg_check_modules(SSL REQUIRED libssl)
pkg_check_modules(URIPARSER REQUIRED liburiparser)
pkg_check_modules(UUID REQUIRED uuid)

pkg_check_modules(LIBUSB libusb-1.0)
if(LIBUSB_FOUND)
    set(HAVE_LIBUSB ${LIBUSB_FOUND})
endif()

pkg_check_modules(LIBMODBUS libmodbus>=3)
if(LIBMODBUS_FOUND)
    set(HAVE_LIBMODBUS ${LIBMODBUS_FOUND})
endif()

find_package(Threads REQUIRED)
find_package(PythonInterp 2.7 REQUIRED)
find_package(PythonLibs 2.7 REQUIRED)
find_package(Boost REQUIRED COMPONENTS python serialization thread)
find_package(GTK2 REQUIRED)

if (PYTHON_VERSION_STRING AND PYTHONLIBS_VERSION_STRING)
    if(NOT PYTHON_VERSION_STRING VERSION_EQUAL PYTHONLIBS_VERSION_STRING)
        message(FATAL_ERROR
            "Version mismatch between python interpreter and libraries")
    endif()
endif()

find_program(YAPPS yapps)
if(NOT YAPPS)
    message(FATAL_ERROR "yapps not found: install yapps2 package")
endif()

find_program(PIDOF pidof)
if(NOT PIDOF)
    message(FATAL_ERROR "pidof not found: install sysvinit-utils")
endif()

find_program(CYTHON cython)
if(NOT CYTHON)
    message(FATAL_ERROR "cython not found: install cython")
endif()

find_program(CCACHE_FOUND ccache)
if(CCACHE_FOUND)
    set_property(GLOBAL PROPERTY RULE_LAUNCH_COMPILE ccache)
    set_property(GLOBAL PROPERTY RULE_LAUNCH_LINK ccache)
endif(CCACHE_FOUND)
