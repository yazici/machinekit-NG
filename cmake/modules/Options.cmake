option(WITH_USERMODE_PCI "Build PCI drivers with usermode PCI support" ON)
option(WITH_XENOMAI "Build Xenomai userland threads" ON)

## Makefile.inc.in defines
set(HAVE_POSIX_THREADS "yes")
set(HAVE_RT_PREEMPT_THREADS "yes")
set(HAVE_XENOMAI_THREADS "no")
set(HAVE_XENOMAI_KERNEL_THREADS "no")
set(HAVE_RTAI_KERNEL_THREADS "no")

find_program(XENO_CONFIG xeno-config)
if(NOT XENO_CONFIG OR NOT WITH_XENOMAI)
    message(WARNING "xenomai flavor disabled")
    set(BUILD_THREAD_FLAVORS posix rt_preempt)
    set(with_xenomai "undef")
    unset(XENOMAI_SKIN)
else()
    set(BUILD_THREAD_FLAVORS posix rt_preempt xenomai)
    set(XENOMAI_SKIN native)
    set(with_xenomai "define")
    ## Makefile.inc.in defines
    set(HAVE_XENOMAI_THREADS "yes")
    unset(ENV{DESTDIR})
    execute_process(COMMAND ${XENO_CONFIG} --skin ${XENOMAI_SKIN} --cflags
                    OUTPUT_VARIABLE XENO_CFLAGS
                    OUTPUT_STRIP_TRAILING_WHITESPACE)
    execute_process(COMMAND ${XENO_CONFIG} --skin ${XENOMAI_SKIN} --ldflags
                    OUTPUT_VARIABLE XENO_LDFLAGS
                    OUTPUT_STRIP_TRAILING_WHITESPACE)
endif()

include(CheckIncludeFiles)

check_include_files(linux/hidraw.h HIDRAW_H_USABLE)
