FROM danielrs975/ros-melodic-rosbridge:0.1

# ----------------- Installation of Gazebo 9 -------------------------
# setup timezone
RUN apt-get update && \
    apt-get install -q -y --no-install-recommends tzdata && \
    rm -rf /var/lib/apt/lists/*

# install packages
RUN apt-get update && apt-get install -q -y --no-install-recommends \
    dirmngr \
    gnupg2 \
    lsb-release \
    && rm -rf /var/lib/apt/lists/*

# setup keys
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D2486D2DD83DB69272AFE98867170598AF249743

# setup sources.list
RUN . /etc/os-release \
    && echo "deb http://packages.osrfoundation.org/gazebo/$ID-stable `lsb_release -sc` main" > /etc/apt/sources.list.d/gazebo-latest.list

# install gazebo packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    gazebo9=9.16.0-1* \
    && rm -rf /var/lib/apt/lists/*

# install gazebo packages
RUN apt-get update && apt-get install -y \
    ros-melodic-gazebo-ros-pkgs ros-melodic-gazebo-ros-control \
    && rm -rf /var/lib/apt/lists/*

# ---------------------------------------------------------------------

COPY ./docker_entrypoint.sh /

# These volumes allow Gazebo to use the
# video card of the localhost to make the
# simulation
VOLUME [ "/tmp/.X11-unix", "/dev/dri" ]

# PORT of Gazebo
EXPOSE 11345 

ENTRYPOINT [ "/docker_entrypoint.sh" ]