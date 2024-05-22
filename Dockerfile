FROM nvcr.io/nvidia/deepstream:6.3-samples

# Install additional packages
RUN apt-get update && apt-get install -y \
    libjson-glib-dev \
    #libssl3 \
    libssl-dev \
    libgstreamer1.0-0 \
    gstreamer1.0-tools \
    gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-bad \
    gstreamer1.0-plugins-ugly \
    gstreamer1.0-libav \
    libgstreamer-plugins-base1.0-dev \
    libgstrtspserver-1.0-0 \
    libgstrtspserver-1.0-dev \
    libjansson4 \
    libyaml-cpp-dev \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get -y --no-install-recommends install \
    git \
    autoconf \
    automake \
    libtool \
    gstreamer-1.0 \
    gstreamer1.0-dev \
    libgstreamer1.0-0 \
    gstreamer1.0-plugins-base \
    gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-bad \
    gstreamer1.0-plugins-ugly \
    gstreamer1.0-libav \
#    gstreamer1.0-doc \
    gstreamer1.0-tools \
#    gstreamer1.0-x \
#    gstreamer1.0-alsa \
#    gstreamer1.0-gl \
#    gstreamer1.0-gtk3 \
#    gstreamer1.0-qt5 \
#    gstreamer1.0-pulseaudio \
#    python-gst-1.0 \
#    libgirepository1.0-dev \
    libcairo2-dev \
    gir1.2-gstreamer-1.0 \
    python3-gi
#    python-gi-dev


RUN pkg-config --cflags json-glib-1.0

WORKDIR /opt/nvidia/deepstream/deepstream/sources/apps/sample_apps/

COPY . deepstream-video-analytics-cafe

RUN cd deepstream-video-analytics-cafe/config && \
    chmod +x model.sh && \
    ./model.sh && \
    cd ..

WORKDIR /opt/nvidia/deepstream/deepstream/sources/apps/sample_apps/deepstream-video-analytics-cafe/

RUN CUDA_VER=12.3 make

ENTRYPOINT ["scripts/entrypoint.sh"]