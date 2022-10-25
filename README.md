# MTB docker image


## Build

1. Download the [Linux tar ModusToolbox](https://softwaretools.infineon.com/tools/com.ifx.tb.tool.modustoolbox?_ga=2.170271651.224088664.1666707216-368252345.1660822691) software into the repository root folder. 
It is expected to follow this naming:

    ModusToolbox_${MTB_PACKAGE_VERSION}-linux-install.tar.gz

2. Build the image specifying the package version and the ModusToolbox version:

    $ docker build --build-arg MTB_PACKAGE_VERSION=3.0.0.9369 --build-arg MTB_VERSION=3.0 -t mpy-mtb .


## Run 

Interactive mode:

    $ docker run --name mtb -it mpy-mtb /bin/bash

## Publish 

    $ docker login
    $ docker tag mpy-mtb:${VERSION} ifxmakers/mpy-mtb-ci:${VERSION}
    $ docker tag mpy-mtb:${VERSION} ifxmakers/mpy-mtb-ci:latest
    $ docker push ifxmakers/mpy-mtb-ci:${VERSION}
    $ docker push ifxmakers/mpy-mtb-ci:latest

