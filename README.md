# MTB docker image

## Build MTB 3.0 Image

1. Download the [Linux tar ModusToolbox](https://softwaretools.infineon.com/tools/com.ifx.tb.tool.modustoolbox?_ga=2.170271651.224088664.1666707216-368252345.1660822691) software into the repository root folder. 
It is expected to follow this naming:

    ModusToolbox_${MTB_PACKAGE_VERSION}-linux-install.tar.gz

2. Build the image specifying the package version and the ModusToolbox version:

    $ docker build -f Dockerfile-mtb30 --build-arg MTB_PACKAGE_VERSION=3.0.0.9369 --build-arg MTB_VERSION=3.0 -t mpy-mtb .

## Build MTB 3.6 Image

1. Donwload all the required tools listed in the [Installation MTB PSOC Edge Tools](https://github.com/Infineon/micropython-psoc-edge/tree/psoc-edge-main/ports/psoc-edge#installation-of-mtb-psoc-edge-tools) section of the PSOC Edge MicroPython port README.
They must be located in the same location of the `Dockferfile-mtb36`.

2. Build the image specifying the version of each of the ModusToolbox toolchain tools:

    $ docker build \
     -f Dockerfile-mtb36 \
     --build-arg MTB_TOOLS_PACKAGE_VERSION=3.6.0.17979 \
     --build-arg MTB_GCC_VERSION=14.2.1.265 \
     --build-arg MTB_EDGE_PROTECT_SEC_SUITE_VERSION=1.6.0.512 \
     --build-arg MTB_PROGTOOLS_VERSION=1.5.0.1534 \
     --build-arg MTB_VERSION=3.6 \
     -t mpy-mtb36 .


## Run 

Interactive mode:

    $ docker run --name mtb -it mpy-mtb /bin/bash

## Publish 

    $ docker login
    $ docker tag mpy-mtb ifxmakers/mpy-mtb-ci:${VERSION}
    $ docker tag mpy-mtb ifxmakers/mpy-mtb-ci:latest
    $ docker push ifxmakers/mpy-mtb-ci:${VERSION}
    $ docker push ifxmakers/mpy-mtb-ci:latest

In case of MTB 3.6, use `mpy-mtb36-ci`.
