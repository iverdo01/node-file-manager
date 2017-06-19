FROM alpine
MAINTAINER DUONG Dinh Cuong <cuong3ihut@gmail.com>

COPY . /node-file-manager
WORKDIR /node-file-manager
VOLUME  /var/www/html/uploads

# bower requires this configuration parameter to allow bower install using root.
RUN echo '{ "allow_root": true }'>.bowerrc

# node-sass doesn't support Alpine, so we need the build toolchain.
RUN apk --update add curl git ca-certificates python build-base nodejs &&\
    npm update -g npm && npm install &&\
    apk del ca-certificates git python build-base &&\
    rm -rf /var/lib/apt/lists/* &&\
    rm -rf /var/cache/apk/*

EXPOSE 8080

CMD node --harmony lib/index.js -p 8080 -d /var/www/html/uploads
