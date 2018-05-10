FROM i386/ubuntu:18.04

MAINTAINER Radu Suciu <radusuciu@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -y install \
    software-properties-common \
    wget \
    xvfb \
    apt-transport-https \
    wine-stable

# install and update winetricks
ADD https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks /usr/local/bin/
RUN chmod 755 /usr/local/bin/winetricks
RUN winetricks --self-update

# make a 'wine user'
RUN adduser --disabled-password --gecos '' wine
RUN chown -R wine:wine /home/wine
RUN chown wine:wine /usr/local/bin/winetricks
USER wine

WORKDIR /home/wine
COPY --chown=wine:wine readw readw/
COPY --chown=wine:wine install.sh .
COPY --chown=wine:wine run.sh .

# volume for output
VOLUME ["/output"]

RUN bash install.sh

# shortcut inside container for convenience 
RUN echo 'alias readw="wine /home/wine/readw/ReAdW.exe --mzXML --centroid"' >> .bashrc

ENTRYPOINT ["/home/wine/run.sh"]
