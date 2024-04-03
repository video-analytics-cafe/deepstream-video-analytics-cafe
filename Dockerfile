FROM nvcr.io/nvidia/deepstream:6.4-gc-triton-devel

# Install additional apt packages
RUN apt-get update && apt-get install -y \
    xvfb \
    libssl3 \
    libssl-dev \
    libgstreamer1.0-0 \
    gstreamer1.0-tools \
    gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-bad \
    gstreamer1.0-plugins-ugly \
    gstreamer1.0-libav \
    libgstreamer-plugins-base1.0-dev \
    libgstrtspserver-1.0-0 \
    libjansson4 \
    libyaml-cpp-dev \
    libjsoncpp-dev \
    protobuf-compiler \
    gcc \
    make \
    git \
    python3 \
    ffmpeg \
    libmpg123-0 \
    && rm -rf /var/lib/apt/lists/*

ENV NVIDIA_DRIVER_CAPABILITIES video,compute,graphics,utility
ENV NVIDIA_VISIBLE_DEVICES all
ENV GST_DEBUG=3
ENV CUDA_VER=12.3
ENV CUDA_HOME=/usr/local/cuda-${CUDA_VER}
ENV CFLAGS="-I$CUDA_HOME/include $CFLAGS"
ENV PATH=${CUDA_HOME}/bin:${PATH}

RUN pkg-config --cflags json-glib-1.0

WORKDIR /opt/nvidia/deepstream/deepstream/sources/apps/sample_apps/

COPY . deepstream-video-analytics-cafe

RUN cd deepstream-video-analytics-cafe/config && \
    chmod +x model.sh && \
    ./model.sh && \
    cd ..

WORKDIR /opt/nvidia/deepstream/deepstream/sources/apps/sample_apps/deepstream-occupancy-analytics/

#RUN CUDA_VER=12.3 make
