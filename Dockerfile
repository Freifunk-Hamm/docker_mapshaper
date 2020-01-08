FROM node:alpine
LABEL maintainer="christian.weiss@ffhamm.de"

RUN npm install --no-cache -g mapshaper@0.4.152

WORKDIR /data
ENTRYPOINT ["/usr/local/bin/mapshaper"]
CMD ["-h"]