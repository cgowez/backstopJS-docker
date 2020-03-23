FROM node:10.15.3

ENV BACKSTOPJS_VERSION=4.5.0

# Base packages
RUN apt-get update && \
	apt-get install -y git sudo software-properties-common

ADD utils/headless-chrome /usr/bin/headless-chrome
RUN chmod a+x /usr/bin/headless-chrome

RUN sudo npm install -g --unsafe-perm=true --allow-root backstopjs@${BACKSTOPJS_VERSION}

RUN wget https://dl-ssl.google.com/linux/linux_signing_key.pub && sudo apt-key add linux_signing_key.pub
RUN sudo add-apt-repository "deb http://dl.google.com/linux/chrome/deb/ stable main"

RUN	apt-get -y update && apt-get -y install google-chrome-stable

RUN apt-get -qqy update \
  && apt-get -qqy --no-install-recommends install \
    libfontconfig \
    libfreetype6 \
    xfonts-cyrillic \
    xfonts-scalable \
    fonts-liberation \
    fonts-ipafont-gothic \
    fonts-wqy-zenhei \
  && rm -rf /var/lib/apt/lists/* \
  && apt-get -qyy clean

RUN mv /opt/google/chrome/google-chrome /opt/google/chrome/google-chrome-browser \
   && rm /usr/bin/google-chrome-stable \
   && rm /usr/bin/google-chrome \
   && ln -s /opt/google/chrome/google-chrome-browser /usr/bin/chrome \
   && ln -s /usr/bin/headless-chrome /usr/bin/google-chrome

WORKDIR /src

RUN chrome --version

ENTRYPOINT ["backstop"]
