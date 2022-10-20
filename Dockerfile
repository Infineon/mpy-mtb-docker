FROM ubuntu

# Install tools
RUN apt-get update

RUN apt install -y \
    make \
    git \
    cmake \
    perl \
    libncurses5 \
    libusb-1.0-0 \
    libxcb-xinerama0 \
    sudo 

RUN make -version
RUN git --version
RUN cmake --version

# ModusToolbox is located locally in the repository during build
# as it is not available through wget or a package manager
COPY ModusToolbox_3.0.0.9369-linux-install.tar.gz .

# Run all installation script for ModusToolbox
RUN tar -xf ModusToolbox_3.0.0.9369-linux-install.tar.gz
RUN cd ModusToolbox/tools_3.0/openocd/udev_rules \
    && sh install_rules.sh 

    # && sh ModusToolbox/tools_3.0/driver_media/install_rules.sh \
    # && sh ModusToolbox/tools_3.0/fw-loader/udev_rules/install_rules.sh \
    # && sh ModusToolbox/tools_3.0/modus-shell/postinstall \
    # && bash ModusToolbox/tools_3.0/idc_registration-3.0.0.bash