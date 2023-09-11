FROM node:12-alpine

RUN apk add --update nodejs npm

USER node

WORKDIR /home/node/app

COPY --chown=node:node package.json package-lock.json ./
RUN npm ci

COPY --chown=node:node . .

EXPOSE 3000

CMD [ "node", "index.js" ]
