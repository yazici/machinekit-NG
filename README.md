This repo contains a testing version of Machinekit, with only HAL elements present.

Subject to unnotified change or deletion.

To build:
(items in `[]` are optional)

cd build

cmake ../ `[-DCMAKE_INSTALL_PREFIX=/path/to/install/to]`  (defaults to /usr/local)

make -j${nproc}

make setuid

cd ../

. ./scripts/rip-environment

Alternately, from the 'build' dir

`[make install]`

Once installed there is an option to uninstall, so long as you do not clean the repo

`[./uninstall]`
