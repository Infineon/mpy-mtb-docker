FROM ubuntu:20.04

# https://askubuntu.com/questions/909277/avoiding-user-interaction-with-tzdata-when-installing-certbot-in-a-docker-contai
ENV DEBIAN_FRONTEND=noninteractive  
ENV UDEV=1

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
    sudo \
    python3-pip \
    udev

RUN pip install black
RUN pip install pyserial

RUN git clone https://github.com/uncrustify/uncrustify.git --branch uncrustify-0.72.0 && \
    cd uncrustify && \
    mkdir build && \
    cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release .. && \
    make install


ARG MTB_PACKAGE_VERSION
ARG MTB_VERSION

# Environment variables
ENV HOME=/home
ENV MTB_TOOLS_DIR=${HOME}/ModusToolbox/tools_${MTB_VERSION}

# ModusToolbox is located locally in the repository during build
# as it is not available through wget or a package manager
COPY ModusToolbox_${MTB_PACKAGE_VERSION}-linux-install.tar.gz ${HOME}

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

# Add MTB gcc and project-creator tool to path
ENV PATH "${MTB_TOOLS_DIR}/openocd/bin:${MTB_TOOLS_DIR}/library-manager:${MTB_TOOLS_DIR}/gcc/bin:$PATH"

CMD ["/bin/bash"]