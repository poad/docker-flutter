ARG FLUTTER_VERSION="1.22.4"

FROM buildpack-deps:buster-curl

LABEL maintainer="Kenji Saito<ken-yo@mbr.nifty.com>"

ARG FLUTTER_VERSION

RUN TEMP_DIR=$(mktemp -d) \
 && curl -sSLo ${TEMP_DIR}/flutter_linux_${FLUTTER_VERSION}_stable.tar.xz https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz \
 && apt-get update -qq \
 && apt-get install -qqy --no-install-recommends \
     software-properties-common \
     libglu1-mesa \
     xz-utils \
 && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E1DD270288B4E6030699E45FA1715D88E1DF1F24 \
 && add-apt-repository "deb http://ppa.launchpad.net/git-core/ppa/ubuntu eoan main" -y \
 && apt-get update -qq \
 && apt-get install -qqy --no-install-recommends git \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && tar xf ${TEMP_DIR}/flutter_linux_${FLUTTER_VERSION}_stable.tar.xz -C /usr/local/ \
 && rm -rf ${TEMP_DIR}
 
ENV PATH=/usr/local/flutter/:/usr/local/bin/:${PATH}
