FROM node:latest
RUN set -o pipefail && wget -qO - http://www.mongodb.org/static/pgp/server-4.4.asc | apt-key add
RUN echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.4.list
RUN apt-get update && apt-get install -y mongodb-org ffmpeg imagemagick git
RUN mkdir -vp media/_thumbnails
RUN git clone --branch 2.5.4 https://github.com/colloqi/pisignage-server /usr/src/app

VOLUME ["/usr/src/media"]

WORKDIR /usr/src/app

RUN npm install

COPY env.js config/env/docker.js
ENV NODE_ENV docker
ENV MONGO_URI mongodb://127.0.0.1:3000
ENV PORT 3000
EXPOSE 3000

CMD node server.js
