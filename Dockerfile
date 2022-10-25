FROM ubuntu:20.04

# https://askubuntu.com/questions/909277/avoiding-user-interaction-with-tzdata-when-installing-certbot-in-a-docker-contai
ENV DEBIAN_FRONTEND=noninteractive  

# Install tools
RUN apt-get update && apt-get upgrade -y

RUN apt install -y \
    make \
    git \
    cmake \
    perl \
    python3 \
    libncurses5 \
    libusb-1.0-0 \
    libxcb-xinerama0 \
    libglib2.0-0 \
    libgl1-mesa-dev \
    sudo

# TODO: Create a file with all the tools versions and at it to the container
RUN make -version
RUN git --version
RUN cmake --version

ARG MTB_PACKAGE_VERSION
ARG MTB_VERSION

# Environment variables
ENV HOME=/home
ENV MTB_TOOLS_DIR=${HOME}/ModusToolbox/tools_${MTB_VERSION}

# ModusToolbox is located locally in the repository during build
# as it is not available through wget or a package manager
COPY ModusToolbox_${MTB_PACKAGE_VERSION}-linux-install.tar.gz ${HOME}
COPY mtb-export.sh ${HOME}

# Run all installation script for ModusToolbox
RUN cd ${HOME} \
    && tar -xf ModusToolbox_${MTB_PACKAGE_VERSION}-linux-install.tar.gz

RUN cd ${MTB_TOOLS_DIR}/openocd/udev_rules \
    && sh install_rules.sh 
RUN cd ${MTB_TOOLS_DIR}/driver_media \
    && sh install_rules.sh
RUN cd ${MTB_TOOLS_DIR}/fw-loader/udev_rules \
    && sh install_rules.sh
RUN cd ${MTB_TOOLS_DIR}/modus-shell \
    && sh postinstall
RUN cd ${MTB_TOOLS_DIR} \
    && bash idc_registration-3.0.0.bash

# Add tools to system path

RUN cd /home \
    && echo "\nexport PATH=\"${MTB_TOOLS_DIR}/gcc/bin:$PATH:${MTB_TOOLS_DIR}/project-creator\"" >> .bashrc
