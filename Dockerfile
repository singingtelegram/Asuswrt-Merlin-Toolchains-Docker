FROM ubuntu:16.04
MAINTAINER Antonio Aloisio <gnuton@gnuton.org>

env PATH ${PATH}:/opt/brcm-arm/bin
env DEBIAN_FRONTEND noninteractive

WORKDIR /build

RUN \
    dpkg --add-architecture i386 && \
    apt update && \
    apt install -y libtool-bin cmake libproxy-dev uuid-dev liblzo2-dev autoconf automake bash bison bzip2 diffutils file flex m4 g++ gawk groff-base libncurses-dev libtool libslang2 make patch perl pkg-config shtool subversion tar texinfo zlib1g zlib1g-dev git-core gettext libexpat1-dev libssl-dev cvs gperf unzip python libxml-parser-perl gcc-multilib gconf-editor libxml2-dev g++-multilib gitk libncurses5 mtd-utils libncurses5-dev libvorbis-dev git autopoint autogen sed build-essential intltool libelf1 libglib2.0-dev xutils-dev lib32z1-dev lib32stdc++6 xsltproc gtk-doc-tools libelf1:i386 && \
    ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata && \

# clone firmware repo - this should be actually a mouted dir
RUN \
    git clone --single-branch -b dsl https://github.com/denizsokmen/dsl-ac68u.git && \
    rm dsl-ac68u/release/src-rt-6.x.4708/toolchains
    
# setup BCM-SDK
RUN \
    git clone --single-branch -b master https://github.com/RMerl/am-toolchains && \
    ln -s $PWD/am-toolchains/brcm-arm-sdk/hndtools-arm-linux-2.6.36-uclibc-4.5.3 /opt/brcm-arm && \
    ln -s $PWD/am-toolchains/brcm-arm-sdk  $PWD/dsl-ac68u/release/src-rt-6.x.4708/toolchains && \
    