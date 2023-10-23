FROM ubuntu:20.04
RUN apt-get update &&  DEBIAN_FRONTEND=noninteractive apt-get install -y git net-tools ssh \
	python-setuptools python-pygame python-opengl \
  	python-dev build-essential libgl1-mesa-dev \
  	libgles2-mesa-dev zlib1g-dev
RUN apt-get -y install pkg-config 
RUN apt-get -y install libpangoft2-1.0-0 gstreamer-1.0
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install python3-dev build-essential git make autoconf automake libtool \
      pkg-config cmake ninja-build libasound2-dev libpulse-dev libaudio-dev \
      libjack-dev libsndio-dev libsamplerate0-dev libx11-dev libxext-dev \
      libxrandr-dev libxcursor-dev libxfixes-dev libxi-dev libxss-dev libwayland-dev \
      libxkbcommon-dev libdrm-dev libgbm-dev libgl1-mesa-dev libgles2-mesa-dev \
      libegl1-mesa-dev libdbus-1-dev libibus-1.0-dev libudev-dev fcitx-libs-dev
RUN apt-get install -y libgstreamer-plugins-base1.0-dev
RUN apt-get install -y libsdl1.2-dev libsdl1.2debian
RUN apt-get install -y libsdl2-dev
RUN apt-get install -y python3-kivy python3-pip
RUN pip3 install cython packaging
RUN pip3 install kivy
RUN pip3 install kivy-examples
# /usr/local/share/kivy-examples/demo/pictures
#CMD ["/usr/bin/xeyes"]