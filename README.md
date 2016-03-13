This repo contains a testing version of Machinekit, with only HAL elements present.

Subject to unnotified change or deletion.

To build a RIP:
~~~~~~~~~~~~~~~

$ cd build

$ cmake ../ 

$ make -j${nproc}

$ sudo make setuid

$ cd ../

$ . ./scripts/rip-environment

Alternately to build to install:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

from the 'build' dir

$ cmake ../ -DINSTALL_PREFIX=/path/to/install/to

$ make -j${nproc}

$ sudo make setuid

$ make install

Once installed there is an option to uninstall from build/, so long as you do not clean the repo
because it uses cmake install manifest

$ ./uninstall

Alternately to build a debian package:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

As root from root dir of repo

# debian/configure -x -p  (for posix and rt-preempt)

# debian/rules

# DEBIAN_KERNEL_JOBS=${nproc} debian/rules binary

Will build a debian package called

../machinekit-hal_0.1_{your system type}.deb

