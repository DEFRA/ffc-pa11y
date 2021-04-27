ARG PARENT_VERSION=1.2.5-node14.16.1
ARG PA11Y_VERSION=2.4.1

FROM defradigital/node-development:${PARENT_VERSION}

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true
WORKDIR /home/node

USER root

RUN apk update && apk upgrade && \
    echo @edge http://nl.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories && \
    echo @edge http://nl.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories && \
    apk add --no-cache \
        chromium@edge=86.0.4240.111-r0 \
        nss@edge \
        freetype@edge \
        harfbuzz@edge \
        ttf-freefont@edge

RUN npm install --global pa11y-ci@${PA11y_VERSION}

USER node

CMD pa11y-ci
