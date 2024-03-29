FROM        buildbot/buildbot-master:v3.5.0
MAINTAINER  alicef@gentoo.org

USER root
# This will make apt-get install without question
ARG DEBIAN_FRONTEND=noninteractive

RUN /buildbot_venv/bin/pip3 --no-cache-dir install 'buildbot-tyrian-theme'

# We cannot RUN useradd -d /var/lib/buildbot buildbot since useradd is not present
# So let's create user ad hand
RUN echo 'buildbot:x:1000:1000:Buildbot:/var/lib/buildbot:/sbin/nologin' >> /etc/passwd
RUN chown -R buildbot /var/lib/buildbot
USER buildbot
COPY buildbot-config.yaml /var/lib/buildbot
